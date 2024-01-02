//
//  WeatherManager.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import CoreLocation
import WeatherKit

class WeatherManager {
    
    let locationManager = LocationManager()
    let weatherService = WeatherService()
    let weather = Weather()
    
    func fetchWeather(completion: @escaping (Weather?, Error?) -> Void) {
        // 위치를 받아온다.
        locationManager.fetchLocation { [weak self] coordinate, error in
            if let coordinate = coordinate {
                // 위치를 받아오면, 날씨를 받아온다.
                self?.weatherService.fetchWeather(coordinate: coordinate) { weather, error in
                    if let weather = weather {
                        // 날씨를 받아오면, 날씨를 업데이트한다.
                        self?.weather.update(weather)
                    }
                    completion(weather, error)
                }
            } else {
                completion(nil, error)
            }
        }
    }

    
}
