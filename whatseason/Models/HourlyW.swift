//
//  HourlyW.swift
//  whatseason
//
//  Created by namdghyun on 1/20/24.
//

import Foundation

// MARK: - 초단기예보 모델
struct HourlyW {
    var date: Date                  // [DATE]
    var temperature: Double?        // [T1H] 기온
    var precipitation: String?      // [RN1] 1시간 강수량 (mm)
    var skyStatus: Int?             // [SKY] 하늘상태 (맑음, 구름 많음 등)
    // 하늘상태[SKY] 코드: 맑음(1), 구름많음(3), 흐림(4)
    var rainType: Int?              // [PTY] 강수형태
    // 강수형태[PTY] 코드: 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4)
    var humidity: Int?              // [REH] 습도
    var windSpeed: Double?          // [WSD] 풍속 (deg)
    var windDirection: Int?         // [VEC] 풍향 (m/s)
    
    func translateWindDirection() -> String {
        switch windDirection! {
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
}
