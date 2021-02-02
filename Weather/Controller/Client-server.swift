//
//  Client-server.swift
//  Weather
//
//  Created by Developer on 31.01.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

func getCityItemFromJSON(weatherData: JSON, cityName: String = "", lat: String = "", lon: String = "", id: Int = 0) -> cityItem {
    let weatherConditionsCode = weatherData["fact"]["condition"].stringValue
    let (weatherConditions,iconName) = getWeatherConditionsName(weatherConditionsCode: weatherConditionsCode)
    let degreeCelsius = weatherData["fact"]["temp"].stringValue
    let forecastsArrJSON = weatherData["forecasts"].arrayValue
    var forecastsArr: [forecastItem] = []
    for forecastJSON in forecastsArrJSON {
        let dateOfWeek = getDayOfWeek(forecastJSON["date"].stringValue)
        let tempDay = forecastJSON["parts"]["day"]["temp_avg"].stringValue
        let tempNight = forecastJSON["parts"]["night"]["temp_avg"].stringValue
        let (_, conditionIcon) = getWeatherConditionsName(weatherConditionsCode: forecastJSON["parts"]["day"]["condition"].stringValue)
        forecastsArr.append(forecastItem(dateOfWeek: dateOfWeek, tempDay: tempDay, tempNight: tempNight, conditionIcon: conditionIcon))
    }
    return cityItem(id:id, lat: "", lon: "", name: cityName, weatherConditions: weatherConditions, degreeCelsius: degreeCelsius, iconName: iconName, forecasts: forecastsArr)
}

func getYWeatherParams(lat:String, lon:String) -> Parameters {
    return [
        "lat": lat,
        "lon": lon,
        "lang":"ru_RU",
        "limit":"7",
        "extra": "false"
        ]
}
func getGeoParams(cityName:String) -> Parameters {
    return [
        "format": "json",
        "apikey": geocodeKey,
        "geocode": cityName
    ]
}

func getGeocodeParamsFromJSON(geocodeData: JSON) -> (String, String, String) {
    let cityName = geocodeData["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["metaDataProperty"]["GeocoderMetaData"]["Address"]["formatted"].stringValue
    let latLonStr = geocodeData["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["Point"]["pos"].stringValue
    if latLonStr == "" {
        return ("", "not found","not found")
    }
    let latLonArr = latLonStr.components(separatedBy: " ")
    return (cityName,latLonArr[1],latLonArr[0])
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
            "extra": "false"
            ]
    }
    //Запрос на сервер
    AF.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { response in
        switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                print(error)
        }
    }
}

let daysArr = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
func getDayOfWeek(_ today:String) -> String {
    let formatter  = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    guard let todayDate = formatter.date(from: today) else { return "" }
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = daysArr[myCalendar.component(.weekday, from: todayDate)-1]
    return weekDay
}

func getWeatherConditionsName(weatherConditionsCode:String) -> (String, String) {
    switch weatherConditionsCode {
    case "clear":
        return ("Ясно","sun.png")
    case "partly-cloudy", "cloudy", "overcast":
        return ("Облачно","cloudy.png")
    case "drizzle", "light-rain", "rain", "moderate-rain", "heavy-rain", "continuous-heavy-rain", "showers":
        return ("Дождь","rain.png")
    case "wet-snow":
        return ("Дождь со снегом","wet-snow.png")
    case "hail":
        return ("Град","wet-snow.png")
    case "light-snow", "snow", "snow-showers":
        return ("Снег","snow.png")
    case "thunderstorm", "thunderstorm-with-rain", "thunderstorm-with-hail":
        return ("Гроза","clear.png")
    case _:
        print("Error with weatherConditionsCode")
    }
    return ("","clear.png")
}

