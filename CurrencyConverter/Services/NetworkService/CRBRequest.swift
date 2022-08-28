//
//  CRBRequest.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import Foundation

protocol IRequest {
    var urlRequest: URLRequest? { get }
}

struct CRBRequest: IRequest {
    var urlRequest: URLRequest?
    var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
        urlRequest = request(stringURL: urlString)
    }
    
    mutating func request(stringURL: String) -> URLRequest? {
        if let url = URL(string: stringURL) {
            urlRequest = URLRequest(url: url, timeoutInterval: 30)
        } else {
            Logger.error("Неправильный URL")
        }
        return urlRequest
    }
}
