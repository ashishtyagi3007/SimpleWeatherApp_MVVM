//
//  WeatherCell.swift
//  SimpleWeatherApp_MVVM
//
//  Created by Ashish Tyagi on 10/12/20.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ vm: WeatherViewModel) {
        self.cityNameLabel.text = vm.name
        self.temperatureLabel.text = "\(vm.currentTemperature.temperature.formatAsDegree)"
    }

}

extension Double {
    
    var formatAsDegree: String {
        return String(format: "%.0f°",self)
    }
    
}
