//
//  CitiesTableViewController.swift
//  Weather
//
//  Created by Developer on 23.01.2021.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    var citiesArr: [cityItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background mesh.png"))
        
        var i = 0
        while i < 10 {
            let tempCity = cityItem(name: "Москва", weatherConditions: "Гроза", degreeCelsius: 10+i)
            citiesArr.append(tempCity)
            i+=1
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
