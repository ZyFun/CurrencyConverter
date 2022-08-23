//
//  CRBParser.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import Foundation

protocol IParserProtocol {
    associatedtype Model
    func parse(data: Data) -> [Model]?
}

class CRBParser: XMLParser, IParserProtocol {
    typealias Model = CRBApiModel
    
    var models: [Model] = []
    
    var currency = ""
    var charCode = ""
    var name = ""
    var value = ""
    
    func parse(data: Data) -> [Model]? {
        let delegate = self
        let parser = XMLParser(data: data)
        parser.delegate = delegate
        parser.parse()
        
        return models
    }
}

extension CRBParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currency = elementName
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if currency == "Name" {
                name = data
            } else if currency == "Value" {
                value = data
            } else if currency == "CharCode" {
                charCode = data
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Valute" {
            let model = Model(charCode: charCode, name: name, valueRub: value)
            print(model)
            models.append(model)
        }
    }
}
