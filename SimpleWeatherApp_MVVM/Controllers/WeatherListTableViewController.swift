//
//  WeatherListTableViewController.swift
//  SimpleWeatherApp_MVVM
//
//  Created by Ashish Tyagi on 10/12/20.
//

import UIKit

class WeatherListTableViewController: UITableViewController {
    
    fileprivate var weatherListViewModel = WeatherListViewModel()
    private var lastUnitSelection :Unit = Unit(rawValue: "imperial") ?? Unit.init(rawValue: "metric")!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let weatherVM = self.weatherListViewModel.modelAt(indexPath.row)
        
        cell.configure(weatherVM)
       
        return cell
    }
    
}

extension WeatherListTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddWeatherCityViewController" {
            
            prepareSegueForAddWeatherCityViewController(segue: segue)
            
        } else if segue.identifier == "SettingsTableViewController" {
            
            prepareSegueForSettingsTableViewController(segue: segue)
            
        }
       
        
    }
    
    private func prepareSegueForSettingsTableViewController(segue: UIStoryboardSegue) {

        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found")
        }
        
        guard let settingsTVC = nav.viewControllers.first as? SettingsTableViewController else {
            fatalError("SettingsTableViewController not found")
        }
        
        settingsTVC.delegate = self
        
    }
    
    private func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found")
        }
        
        guard let addWeatherCityVC = nav.viewControllers.first as? AddWeatherCityViewController else {
            fatalError("AddWeatherCityController not found")
        }
        
        addWeatherCityVC.delegate = self
        
    }
    
}


extension WeatherListTableViewController: AddWeatherDelegate {
    
    func addWeatherDidSave(vm: WeatherViewModel) {
        self.weatherListViewModel.addWeatherViewModel(vm)
        self.tableView.reloadData()
    }
}

extension WeatherListTableViewController: SettingsDelegate {
    
    func settingsDone(vm: SettingsViewModel) {
        
            if self.lastUnitSelection.rawValue != vm.selectedUnit.rawValue {
                self.weatherListViewModel.updateUnit(to: vm.selectedUnit)
                self.tableView.reloadData()
                self.lastUnitSelection = Unit(rawValue: vm.selectedUnit.rawValue)!
            }
        
    }
    
}
