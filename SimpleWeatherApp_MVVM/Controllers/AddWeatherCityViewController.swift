//
//  AddWeatherCityViewController.swift
//  SimpleWeatherApp_MVVM
//
//  Created by Ashish Tyagi on 10/12/20.
//

import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!

    var delegate: AddWeatherDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func saveCityButtonPressed() {
        
        if let city = cityNameTextField.text {
            
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=a99d2743b559e0489dda176b6ed9260b&units=imperial")!
            
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
                
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherVM
            }
            
            Webservice().load(resource: weatherResource) { [weak self] result in
                
                if let weatherVM = result {
                    
                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(vm: weatherVM)
                        self?.dismiss(animated: true, completion: nil)
                    }
                    
                }
                
            }
            
            
        }
       
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
