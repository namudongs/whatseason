//
//  DayWeatherModel.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import Foundation
import WeatherKit
import UIKit

struct DayWeatherModel {
    var date: Date
    var temperatureHigh: Double
    var temperatureLow: Double
    // 기타 필요한 속성들...

    init(from dayWeather: DayWeather) {
        self.date = dayWeather.date
        self.temperatureHigh = dayWeather.temperatureHigh.converted(to: .celsius).value
        self.temperatureLow = dayWeather.temperatureLow.converted(to: .celsius).value
        // 기타 속성 초기화...
    }
}
