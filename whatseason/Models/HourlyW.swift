//
//  HourlyW.swift
//  whatseason
//
//  Created by namdghyun on 1/20/24.
//

import Foundation

// MARK: - 초단기예보 모델
struct HourlyW {
    let date: Date                  // [DATE]
    var temperature: Double?        // [T1H] 기온
    var precipitation: String?      // [RN1] 1시간 강수량 (mm)
    var skyStatus: Int?             // [SKY] 하늘상태 (맑음, 구름 많음 등)
    // 하늘상태[SKY] 코드: 맑음(1), 구름많음(3), 흐림(4)
    var rainType: Int?              // [PTY] 강수형태
    // 강수형태[PTY] 코드: 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4)
    var humidity: Int?              // [REH] 습도
    var windSpeed: Double?          // [WSD] 풍속 (deg)
    var windDirection: Int?         // [VEC] 풍향 (m/s)
}
