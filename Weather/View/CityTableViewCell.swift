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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
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
//        let imgURLString = "https://mt21.ru" + model.pic
//        categoryImage.sd_setImage(with: URL(string: imgURLString), placeholderImage: UIImage(named: "Icon-loading-1"))
    }

}
