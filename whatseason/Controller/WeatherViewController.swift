//
//  WeatherViewController.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import CoreLocation
import WeatherKit
import UIKit

class WeatherViewController: UIViewController {
    
    var weather: ParsedWeather?
    var hourlyForecast: [HourWeather] = []
    var dailyForecast: [DayWeather] = []
    var city: (name: String, placemarkTitle: String, lat: Double, long: Double, timeZone: String) = ("MyCity", "placemarkTitle", 40.86, -74.12, "EST") {
        didSet {
            WeatherManager.shared.getWeatherForLocation(location: CLLocation(latitude: city.lat, longitude: city.long)) { result in
                switch result {
                case .success(let weather):
                    self.weather = weather
                    self.parse(weather: weather)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func parse(weather: ParsedWeather) {
        for idx in 0..<weather.hourlyForecast.count {
            let item = weather.hourlyForecast[idx]
            hourlyForecast.append(item)
        }
        
        for item in weather.dailyForecast {
            dailyForecast.append(item)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
