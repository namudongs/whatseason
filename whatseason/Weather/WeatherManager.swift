//
//  WeatherDataCenter.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherManager {
    static let shared = WeatherManager()
    let weatherService = WeatherService()
    var weather: Weather?
    
    /// Getting when the weather forecast for current user location.
    /// - Parameter location: Current user location.
    /// - Parameter completion:  A closure to call when the weather forecast has been got.
    
    func getWeatherForLocation(
        location: CLLocation,
        completion: @escaping (
            _ result: Result<
            ParsedWeather,
            Error
            >
        ) -> Void
    ) {
        
        Task {
            do {
                let hourlyStartDate = Date.now
                let hourlyEndDate = Date(
                    timeIntervalSinceNow: 60*60*6
                )
                
                let weather2: (
                    currentWeather: CurrentWeather,
                    hourlyForecast: Forecast<HourWeather>,
                    weatherAlerts: [WeatherAlert]?,
                    dailyForecast: Forecast<DayWeather>
                ) = try await weatherService.weather(
                    for: location,
                    including:
                            .current,
                    .hourly(
                        startDate: hourlyStartDate,
                        endDate: hourlyEndDate
                    ),
                    .alerts,
                    .daily
                )
                
                let parsed = ParsedWeather(
                    currentWeather: weather2.currentWeather,
                    hourlyForecast: weather2.hourlyForecast,
                    dailyForecast: weather2.dailyForecast,
                    weatherAlerts: weather2.weatherAlerts
                )
                DispatchQueue.main.async {
                    completion(
                        .success(
                            parsed
                        )
                    )
                }
            } catch {
                DispatchQueue.main.async {
                    completion(
                        .failure(
                            error
                        )
                    )
                }
            }
        }
    }
    
}
