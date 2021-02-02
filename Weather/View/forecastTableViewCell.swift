//
//  forecastTableViewCell.swift
//  Weather
//
//  Created by Developer on 01.02.2021.
//

import UIKit

class forecastTableViewCell: UITableViewCell {
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var degreeCelsiusLabel: UILabel!
    @IBOutlet weak var degreeCelsiusNightLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //заполняем поля ячейки данными
    func refresh(forecastData: forecastItem) {
        dayOfWeekLabel.text = forecastData.dateOfWeek
        degreeCelsiusLabel.text = (String(describing: forecastData.tempDay))+"°"
        degreeCelsiusNightLabel.text = (String(describing: forecastData.tempNight))+"°"
        weatherIcon.image = UIImage(named: forecastData.conditionIcon)
    }
}
