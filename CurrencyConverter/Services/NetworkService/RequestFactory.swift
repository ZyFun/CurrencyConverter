//
//  RequestFactory.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import Foundation

struct RequestFactory {
    struct CBRCurrencyRequest {
        static func modelConfig() -> RequestConfig<CRBParser> {
            let urlString = "http://www.cbr.ru/scripts/XML_daily.asp"
            let request = CRBRequest(urlString: urlString)
            let parser = CRBParser()
            return RequestConfig<CRBParser>(request: request, parser: parser)
        }
    }
}
