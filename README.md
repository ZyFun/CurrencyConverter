![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)
![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
![IOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
<br/>
![UIKit](https://img.shields.io/badge/-UIKit-blue)
![AutoLayout](https://img.shields.io/badge/-AutoLayout-blue)
![XIB](https://img.shields.io/badge/-XIB-blue)
![VIPER](https://img.shields.io/badge/-VIPER-blue)
![UserDefaults](https://img.shields.io/badge/-UserDefaults-blue)
![XMLParser](https://img.shields.io/badge/-XMLParser-blue)
![URLSession](https://img.shields.io/badge/-URLSession-blue)
![URLRequest](https://img.shields.io/badge/-URLRequest-blue)
![GCD](https://img.shields.io/badge/-GCD-blue)
![UnitTests](https://img.shields.io/badge/-UnitTests-blue)

# Конвертер валют
Тестовое задание.

## Description
Простой конвертер валют. На данном этапе есть возможность конвертации выбранной валюты в рубли, и обратно.
Приложение состоит из трёх экранов: главный экран выбора валюты, экран калькулятора, экран избранного.
Конвертация происходит сразу, как только введен или удалён хотя бы 1 символ.
Добавление в избранное осуществляется свайпом по ячейке в левую сторону.
Переход в калькулятор возможен как с главного экрана, так и из избранного.
Название валюты добавленной в избранное окрашивается в оранжевый цвет.

### Описание используемых технологий
- Многопоточность приложения построена на GCD.
- Стараюсь использовать все принципы чистого кода, DRY, KISS, YAGNI, SOLID и SOA (Всё еще не идеально. I'm just learning 😅).
- Приложение написано на архитектуре VIPER. 
- Используется UserDefaults для хранения избранной валюты.
- В приложении присутствует работа с URLSession. С помощью него, из XML подгружаются данные по курсу валют.
- Код частично покрыт Unit тестами.
- Частично, интерфейс написан кодом с помощью AutoLayout.
- Вместо Storyboard использую XIB файлы. 1 экран – 1 XIB.
- Весь дизайн приложения был взять из головы.

## Installations
Clone and run project in Xcode 13 or newer

## Demo
![Demo 1](https://github.com/ZyFun/CurrencyConverter/blob/main/Demo/Demo000.gif?raw=true)
