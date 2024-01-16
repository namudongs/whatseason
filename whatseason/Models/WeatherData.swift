//
//  WeatherData.swift
//  whatseason
//
//  Created by namdghyun on 1/15/24.
//

import Foundation
import WeatherKit

struct WeatherData: Codable {
    let current: CurrentWeather
    let hourly: [HourWeather]
    let daily: [DayWeather]
}
