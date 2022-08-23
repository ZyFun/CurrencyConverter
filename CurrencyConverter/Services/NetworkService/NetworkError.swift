//
//  NetworkError.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL = "⚠️ API Error: Неправильно указан URL."
    case parseError = "Ошибка парсинга данных. Обратитесь к разработчику"
    case networkError = "Ошибка сети. Попробовать загрузить данные еще раз?"
    case statusCodeError = "Ошибка получения кода статуса. Обратитесь к разработчику"
    case serverError = "⚠️ API Error: Сервер недоступен или используется неправильный адрес"
    case requestError = "⚠️ API Error: Ссылка устарела или произошла ошибка запроса данных"
    case unownedError = "Неизвестная ошибка. До свидания"
}
