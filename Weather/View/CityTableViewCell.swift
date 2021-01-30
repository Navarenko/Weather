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
        self.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//      Закругление:
        substrateView.layer.cornerRadius = 10
        substrateView.layer.masksToBounds = true
    }

//TODO: нужна ли анимация по нажатию?
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    //заполняем поля ячейки данными
    func refresh(cityData: cityItem) {
        nameCityLabel.text = cityData.name
        weatherConditionsLabel.text = cityData.weatherConditions
        degreeCelsiusLabel.text = "\(cityData.degreeCelsius)°"
        //изображение
//        weatherIcon.image = UIImage(contentsOfFile: cityData.weatherIconURL)
        //TODO:
//        categoryImage.sd_setImage(with: URL(string: imgURLString), placeholderImage: UIImage(named: "Icon-loading-1"))
    }

}
