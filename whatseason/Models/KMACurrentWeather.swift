//
//  KMAWeatherModel.swift
//  whatseason
//
//  Created by namdghyun on 1/19/24.
//

import Foundation

struct KMACurrentWeather {
    let date: Date  // 현재 날짜와 시간을 저장
    let temperature: Double  // 기온
    let precipitation: Int  // 1시간 강수량
    let rainType: Int  // 강수 형태
    let humidity: Int  // 습도
    let windSpeed: Double  // 풍속
    let windDirection: Int  // 풍향
    
    func translateWindDirection() -> String {
        switch windDirection {
        case 0..<23:
            return "북"
        case 23..<68:
            return "북동"
        case 68..<113:
            return "동"
        case 113..<158:
            return "남동"
        case 158..<203:
            return "남"
        case 203..<248:
            return "남서"
        case 248..<293:
            return "서"
        case 293..<338:
            return "북서"
        default:
            return "북"
        }
    }
    
    func calculateFeelsLikeTemperature() -> Double {
        // 겨울철 조건 확인: 기온 10°C 이하, 풍속 1.3 m/s 이상
        if temperature <= 10 && windSpeed >= 1.3 {
            // 풍속을 km/h로 변환
            let windSpeedKmh = windSpeed * 3.6
            // 겨울철 체감온도 계산
            return 13.12 + 0.6215 * temperature - 11.37 * pow(windSpeedKmh, 0.16) + 0.3965 * temperature * pow(windSpeedKmh, 0.16)
        } else {
            // 습구온도(Tw) 계산
            let Tw = temperature * atan(0.151977 * sqrt(Double(humidity) + 8.313659)) +
            atan(temperature + Double(humidity)) -
            atan(Double(humidity) - 1.676331) +
            0.00391838 * pow(Double(humidity), 1.5) * atan(0.023101 * Double(humidity)) -
            4.686035
            // 여름철 체감온도 계산
            return -0.2442 + 0.55399 * Tw + 0.45535 * temperature - 0.0022 * Tw * Tw + 0.00278 * Tw * temperature + 3.0
        }
    }
}

struct WeatherResponse: Decodable {
    let response: WeatherBody
}

struct WeatherBody: Decodable {
    let header: WeatherHeader
    let body: WeatherItems
}

struct WeatherHeader: Decodable {
    let resultCode: String
    let resultMsg: String
}

struct WeatherItems: Decodable {
    let items: WeatherData
}

struct WeatherData: Decodable {
    let item: [WeatherItem]
}

struct WeatherItem: Decodable {
    let baseDate: String
    let baseTime: String
    let category: String
    let nx: Int
    let ny: Int
    let obsrValue: String
    
    enum CodingKeys: String, CodingKey {
        case baseDate
        case baseTime
        case category
        case nx
        case ny
        case obsrValue
    }
}
