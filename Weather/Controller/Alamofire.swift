//
//  Alamofire.swift
//  Weather
//
//  Created by Developer on 24.01.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

func getCityItemFromJSON(weatherData: JSON, cityName: String = "", lat: String = "", lon: String = "", id: Int = 0) -> cityItem {
    let weatherConditionsCode = weatherData["fact"]["condition"].stringValue
    let weatherConditions = getWeatherConditionsName(weatherConditionsCode: weatherConditionsCode)
    let degreeCelsius = weatherData["fact"]["temp"].stringValue
    return cityItem(id:id, lat: "", lon: "", name: cityName, weatherConditions: weatherConditions, degreeCelsius: degreeCelsius)
}

func getYWeatherParams(lat:String, lon:String) -> Parameters {
    return [
        "lat": lat,
        "lon": lon,
        "lang":"ru_RU",
        "extra": "true"//TODO: false
        ]
}
func getGeoParams(cityName:String) -> Parameters {
    return [
        "format": "json",
        "apikey": geocodeKey,
        "geocode": cityName
    ]
}

func getGeocodeParamsFromJSON(geocodeData: JSON) -> (String, String) {
    let latLonStr = geocodeData["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["Point"]["pos"].stringValue
    let latLonArr = latLonStr.components(separatedBy: " ")
    return (latLonArr[1],latLonArr[0])
}

//Запрос на сервер через Alamofire
func alamofireGetRequest(url: String, params: Parameters? = nil, headers: HTTPHeaders = [], completion: @escaping (JSON) -> Void) {
    var parameters:Parameters
    if params != nil {
        parameters = params!
    } else {
        //тестовые данные
        parameters = [
            "lat": "55.75396",
            "lon": "37.620393",
            "lang":"ru_RU",
            "extra": "true"//false
            ]
    }
    print("1 start ", url)
    //Запрос на сервер
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    completion(json)
                    print("2 got ", url)
                case .failure(let error):
                    print(error)
            }
        }
        
        print("3 finish ", url)
}

func getWeatherConditionsName(weatherConditionsCode:String) -> String {
    switch weatherConditionsCode {
    case "clear":
        return "Ясно"
    case "partly-cloudy", "cloudy", "overcast":
        return "Облачно"
    case "drizzle", "light-rain", "rain", "moderate-rain", "heavy-rain", "continuous-heavy-rain", "showers":
        return "Дождь"
    case "wet-snow":
        return "Дождь со снегом"
    case "light-snow", "snow", "snow-showers":
        return "Снег"
    case "hail":
        return "Град"
    case "thunderstorm", "thunderstorm-with-rain", "thunderstorm-with-hail":
        return "Гроза"
    case _:
        print("Error with weatherConditionsCode")
    }
    return ""
}
