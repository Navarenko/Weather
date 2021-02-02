//
//  CitiesTableViewController.swift
//  Weather
//
//  Created by Developer on 23.01.2021.
//

import UIKit

class CitiesTableViewController: UITableViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(red: 75/255.0, green: 75/255.0, blue: 75/255.0, alpha: 1.0)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
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
                let (_, lat, lon) = getGeocodeParamsFromJSON(geocodeData: geocodeData)
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
    
    func showMessage(view: UIViewController, title: String = "", message: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Хорошо", style: .default) { (action) in
        }
        alertController.addAction(action)
        DispatchQueue.main.async {
            view.present(alertController, animated: true, completion: nil)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArr.count+1
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else {
            return 128
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell {
                
                //цвет ячейки по нажатию
                let backgroundView = UIView()
                backgroundView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = backgroundView
                
                cell.searchTextField.delegate = self
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityTableViewCell {
                
                //цвет ячейки по нажатию
                let backgroundView = UIView()
                backgroundView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = backgroundView
                
                //все действия по заполнению ячейки в отдельном классе
                let curCity = citiesArr[indexPath.row-1]
                cell.refresh(cityData: curCity)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            goToDetailCityViewController(cityItem: citiesArr[indexPath.row-1])
        }
    }
    
    func goToDetailCityViewController(cityItem: cityItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailCityViewController") as! DetailCityViewController
        vc.cityWeatherData = cityItem
        if self.navigationController != nil {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let cityName = textField.text ?? ""
        
        //пробуем найти и открыть введенный город
        if cityName != "" {
            let geoParams = getGeoParams(cityName: cityName)
            alamofireGetRequest(url: geocodeURL, params: geoParams, completion: {(geocodeData) in
                let (cityNameFormatted, lat, lon) = getGeocodeParamsFromJSON(geocodeData: geocodeData)
                if (lat == "not found") {
                    self.showMessage(view: self, title: "Город не найден", message: "Попробуйте ввести еще раз")
                } else {
                    let YWeatherParams = getYWeatherParams(lat: lat, lon: lon)
                    alamofireGetRequest(url: yandexWeatherURL, params: YWeatherParams, headers: yandexWeatherHeaders, completion: {(weatherData) in
                        let city = getCityItemFromJSON(weatherData: weatherData, cityName: cityNameFormatted, lat: lat, lon: lon, id: 0)
                        self.goToDetailCityViewController(cityItem: city)
                    })
                }
            })
        }
        return true
    }
}
