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
    
    var models: [Model]?
    var currency = ""
    var charCode = ""
    var nominal = ""
    var name = ""
    var value = ""
    
    func parse(data: Data) -> [Model]? {
        models = []
        
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
        
        switch currency {
        case "CharCode":
            charCode = data
        case "Nominal":
            nominal = data
        case "Name":
            name = data
        case "Value":
            value = data
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Valute" {
            let model = Model(
                charCode: charCode,
                nominal: nominal,
                name: name,
                valueRub: value
            )
            
            models?.append(model)
        }
    }
}
