//
//  SettingsViewModel.swift
//  SimpleWeatherApp_MVVM
//
//  Created by Ashish Tyagi on 11/12/20.
//

import Foundation

enum Unit: String, CaseIterable {
    
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    
    var displayName: String {
        get {
            switch(self) {
                case .celsius:
                    return "Celsius"
                case .fahrenheit:
                    return "Fahrenheit"
            }
        }
    }
    
}

struct SettingsViewModel {
    
    let units = Unit.allCases
    
}
