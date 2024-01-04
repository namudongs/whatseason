//
//  WeatherService.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import WeatherKit

class WeatherService {
    
    private var weatherKit = Weather?
    
    init() {
        self.weatherKit = Weather()
    }
    
}
