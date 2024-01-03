//
//  WeatherService.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import Foundation
import WeatherKit

class WeatherService {
    
    private var weatherKit: Weather?
    private var currentWeather: WeatherModel?
    private var hourlyForecast: [HourWeather]?
    
    // 날씨 데이터 가져오는 메서드 업데이트
    func fetchCurrentWeather(completion: @escaping (WeatherModel?) -> Void) {
        weatherKit.fetchCurrentWeather { result in
            switch result {
            case .success(let currentWeatherData):
                self.currentWeather = WeatherModel(temperature: currentWeatherData.temperature.value,
                                                  humidity: currentWeatherData.humidity)
                completion(self.currentWeather)
                
            case .failure:
                completion(nil)
            }
        }
    }
    
    // 다른 필요한 메서드들 추가
}
