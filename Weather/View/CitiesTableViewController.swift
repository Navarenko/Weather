//
//  CitiesTableViewController.swift
//  Weather
//
//  Created by Developer on 23.01.2021.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "background mesh.png"))
        
        //наполняем глобальный массив городов данными
        let dispGroup = DispatchGroup()
        var i = 0
        for cityName in startCitiesArr {
            dispGroup.enter()
            let id = i
            i += 1
            let geoParams = getGeoParams(cityName: cityName)
            alamofireGetRequest(url: geocodeURL, params: geoParams, completion: {(geocodeData) in
                let (lat, lon) = getGeocodeParamsFromJSON(geocodeData: geocodeData)
                let YWeatherParams = getYWeatherParams(lat: lat, lon: lon)
                alamofireGetRequest(url: yandexWeatherURL, params: YWeatherParams, headers: yandexWeatherHeaders, completion: {(weatherData) in
                    let city = getCityItemFromJSON(weatherData: weatherData, cityName: cityName, lat: lat, lon: lon, id: id)
                    citiesArr.append(city)
                    dispGroup.leave()
                })
            })
        }
        dispGroup.notify(queue: .main) {
            citiesArr.sort{ $0.id < $1.id }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArr.count
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityTableViewCell {
            let curCity = citiesArr[indexPath.row]
            //все действия по заполнению ячейки в отдельном классе
            cell.refresh(cityData: curCity)
            return cell
        }
        return UITableViewCell()
    }
}
