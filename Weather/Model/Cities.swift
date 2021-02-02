//
//  Cities.swift
//  Weather
//
//  Created by Developer on 24.01.2021.
//

import Foundation

var citiesArr: [cityItem] = []
struct cityItem {
    var id:Int
    var lat:String //широта
    var lon:String //долгота
    var name:String
    var weatherConditions:String
    var degreeCelsius:String
    var iconName:String
    var forecasts: [forecastItem]
}

struct forecastItem {
    var dateOfWeek: String
    var tempDay: String
    var tempNight: String
    var conditionIcon: String
}

let startCitiesArr = ["Москва", "Санкт-Петербург", "Красноярск", "Екатеринбург", "Казань", "Новосибирск", "Челябинск", "Ульяновск", "Омск", "Уфа"]
