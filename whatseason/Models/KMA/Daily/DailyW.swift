//
//  DailyW.swift
//  whatseason
//
//  Created by namdghyun on 1/20/24.
//

import Foundation

// MARK: - 단기예보 모델
struct DailyW {
    let date: Date                  // [DATE]
    var hourlyTemp: Double?         // [T1H] 기온
    var dailyHighTemp: Double?      // [TMX] 일 최고기온
    var dailyLowTemp: Double?       // [TMN] 일 최저기온
    var precipitation: String?      // [POP] 1시간 강수량 (mm)
    var rainProbability: String?    // [PCP] 하늘상태 (맑음, 구름 많음 등)
    var snowProbability: String?    // [SNO] 하늘상태 (맑음, 구름 많음 등)
    var skyStatus: Int?             // [SKY] 하늘상태 (맑음, 구름 많음 등)
    // 하늘상태[SKY] 코드: 맑음(1), 구름많음(3), 흐림(4)
    var rainType: Int?              // [PTY] 강수형태
    // 강수형태[PTY] 코드: 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4)
    var humidity: Int?              // [REH] 습도
    var windSpeed: Double?          // [WSD] 풍속 (deg)
    var windDirection: Int?         // [VEC] 풍향 (m/s)
}
