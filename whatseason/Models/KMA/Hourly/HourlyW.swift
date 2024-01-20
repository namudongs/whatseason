//
//  HourlyW.swift
//  whatseason
//
//  Created by namdghyun on 1/20/24.
//

import Foundation

// MARK: - 초단기예보 모델
struct HourlyW {
    let date: Date            // 예보 날짜와 시간
    var temperature: Double?  // 기온 예보
    var rainProbability: String? // 강수 확률
    var skyStatus: Int?       // 하늘 상태 (맑음, 구름 많음 등)
    var rainType: Int?        // 강수 형태
    var humidity: Int?        // 습도 예보
    var windSpeed: Double?    // 풍속 예보
    var windDirection: Int?   // 풍향 예보
}

struct ForecastResponse: Decodable {
    let response: ForecastBody
}

struct ForecastBody: Decodable {
    let header: ForecastHeader
    let body: ForecastItems
}

struct ForecastHeader: Decodable {
    let resultCode: String
    let resultMsg: String
}

struct ForecastItems: Decodable {
    let items: ForecastData
}

struct ForecastData: Decodable {
    let item: [ForecastItem]
}

struct ForecastItem: Decodable {
    let baseDate: String
    let baseTime: String
    let category: String
    let fcstDate: String
    let fcstTime: String
    let fcstValue: String
    let nx: Int
    let ny: Int
}
