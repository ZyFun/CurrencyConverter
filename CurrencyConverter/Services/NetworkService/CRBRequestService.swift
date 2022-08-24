//
//  CRBRequestService.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import Foundation

protocol IRequestSender {
    func send<Parser>(
        config: RequestConfig<Parser>,
        completionHandler: @escaping (Result<([Parser.Model]?, Data?, URLResponse?), NetworkError>) -> Void
    )
}

struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser?
}

class RequestSender: IRequestSender {
    
    func send<Parser>(
        config: RequestConfig<Parser>,
        completionHandler: @escaping (Result<([Parser.Model]?, Data?, URLResponse?), NetworkError>) -> Void
    ) where Parser: IParser {
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.networkError))
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                completionHandler(.failure(.statusCodeError))
                return
            }
            
            if !(200..<300).contains(statusCode) {
                switch statusCode {
                case 400:
                    completionHandler(.failure(.requestError))
                case 500...:
                    completionHandler(.failure(.serverError))
                default:
                    completionHandler(.failure(.unownedError))
                }
            }
            
            if let data = data,
               let parseModel: [Parser.Model] = config.parser?.parse(data: data) {
                completionHandler(.success((parseModel, nil, nil)))
            } else if let data = data {
                completionHandler(.success((nil, data, response)))
            } else {
                completionHandler(.failure(.parseError))
            }
        }
        task.resume()
    }
}
