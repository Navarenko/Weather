//
//  URLs.swift
//  Weather
//
//  Created by Developer on 25.01.2021.
//

import Foundation
import Alamofire

let yandexWeatherURL = "https://api.weather.yandex.ru/v2/forecast"
let yandexWeatherHeaders: HTTPHeaders = [
    "X-Yandex-API-Key": "bd4933b3-5980-4ec7-b18c-72c4c848d336"
]

let geocodeURL = "https://geocode-maps.yandex.ru/1.x/"
let geocodeKey = "30c11408-c779-45ed-8ac4-848253f67264"
