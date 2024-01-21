//
//  AnyWeather.swift
//  whatseason
//
//  Created by namdghyun on 1/19/24.
//

import WeatherKit

struct AnyW {
    var apple: Weather?
    var currentW: CurrentW?
    var hourlyW: [HourlyW?]?
    var dailyW: [DailyW?]?
    var weeklyW: [WeeklyW]?
    var address: String?
}
