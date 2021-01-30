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
//    var weatherIconURL:String
}

let startCitiesArr = ["Москва", "Санкт-Петербург", "Красноярск", "Екатеринбург", "Казань", "Новосибирск", "Челябинск", "Самара", "Омск", "Уфа"]
