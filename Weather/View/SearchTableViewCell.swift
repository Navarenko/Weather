//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Developer on 01.02.2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchTextField: UITextField!
    {
        didSet {
            searchTextField.attributedPlaceholder = NSAttributedString(string: "Введите город", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 75/255.0, green: 75/255.0, blue: 75/255.0, alpha: 0.5)])
            searchTextField.setIcon(image: UIImage(named: "search.png")!)
        }
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Дизайн:
        self.backgroundColor = UIColor.clear
        //закругление
        searchTextField.layer.cornerRadius = 25
        searchTextField.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension UITextField {
    func setIcon(image: UIImage) {
       let iconView = UIImageView(frame:CGRect(x: 15, y: 5, width: 20, height: 20))
       iconView.image = image
       let iconContainerView: UIView = UIView(frame:CGRect(x: 20, y: 0, width: 45, height: 30))
       iconContainerView.addSubview(iconView)
       leftView = iconContainerView
       leftViewMode = .always
    }
}
