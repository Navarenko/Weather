//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Developer on 23.01.2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var weatherConditionsLabel: UILabel!
    @IBOutlet weak var degreeCelsiusLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var substrateView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Дизайн:
        self.backgroundColor = UIColor.clear
        //закругление
        substrateView.layer.cornerRadius = 15
        substrateView.layer.masksToBounds = true
        //эффект размытия подложки
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.5
        self.substrateView.insertSubview(blurEffectView, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //заполняем поля ячейки данными
    func refresh(cityData: cityItem) {
        nameCityLabel.text = cityData.name
        weatherConditionsLabel.text = cityData.weatherConditions
        degreeCelsiusLabel.text = "\(cityData.degreeCelsius)°"
        weatherIcon.image = UIImage(named: cityData.iconName)
    }

}
