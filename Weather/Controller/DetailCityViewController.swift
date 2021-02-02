//
//  DetailCityViewController.swift
//  Weather
//
//  Created by Developer on 30.01.2021.
//

import UIKit

class DetailCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var cityWeatherData: cityItem?
    
    @IBOutlet weak var nameCityLabel: UILabel! {
        didSet {
            nameCityLabel.text = cityWeatherData?.name
        }
    }
    @IBOutlet weak var todayLabel: UILabel! {
        didSet {
            let date = Date()
            let calendar = Calendar.current
            var todayInt = calendar.component(.weekday, from: date)-2
            if todayInt == -1 {
                todayInt = 6
            }
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            todayLabel.text = "\(daysArr[todayInt]), \(hour):\(minutes)"
        }
    }
    @IBOutlet weak var weatherConditionsLabel: UILabel! {
        didSet {
            weatherConditionsLabel.text = cityWeatherData?.weatherConditions
        }
    }
    @IBOutlet weak var degreeCelsiusLabel: UILabel! {
        didSet {
            degreeCelsiusLabel.text = cityWeatherData?.degreeCelsius
        }
    }
    @IBOutlet weak var weatherIcon: UIImageView! {
        didSet {
            guard let image = cityWeatherData?.iconName else {return}
            weatherIcon.image = UIImage(named: image)
        }
    }
    @IBOutlet weak var forecastTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.forecastTableView.dataSource = self
        self.forecastTableView.delegate = self
        
        //Дизайн:
        self.addBackground()
        forecastTableView.backgroundColor = UIColor.clear
        //закругление
        forecastTableView.layer.cornerRadius = 50
        forecastTableView.layer.masksToBounds = true
        //эффект размытия подложки
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = forecastTableView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.9
        forecastTableView.insertSubview(blurEffectView, at: 0)
    }
    
    func addBackground() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.layer.masksToBounds = true
        imageViewBackground.image = UIImage(named: "Sky-Blue.jpg")
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "forecastTableViewCell", for: indexPath) as? forecastTableViewCell {
            cell.layer.zPosition = 1
            if cityWeatherData != nil {
                cell.refresh(forecastData: cityWeatherData!.forecasts[indexPath.row]) 
            }
            return cell
        }
        return UITableViewCell()
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
}
