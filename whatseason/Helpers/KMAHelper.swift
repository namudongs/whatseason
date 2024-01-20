//
//  KMAHelper.swift
//  whatseason
//
//  Created by namdghyun on 1/20/24.
//

import Foundation

class KMAHelper {
    static func createFormatter(timeZone: TimeZone = .current, locale: Locale = Locale(identifier: "ko")) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmm"
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter
    }
    
    static func createRequestURL(apiURL: String, date: Date, nx: Int, ny: Int) -> String {
        // 초단기실황    http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst
        // 초단기예보    http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst
        // 단기예보     http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst
        
        let baseURL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/"
        let apiKey = Bundle.main.infoDictionary?["KMA_API_KEY"] as! String
        
        let dateFormatter = createFormatter(timeZone: TimeZone(identifier: "Asia/Seoul")!)
        let baseDate = dateFormatter.string(from: date).dropLast(4)
        var baseTime = "0000"
        
        if apiURL == "getUltraSrtFcst" {
            baseTime = calculateBaseTimeForUltraSrtFcst(currentDate: date)
        } else if apiURL == "getVilageFcst" {
            baseTime = calculateBaseTimeForVilageFcst(currentDate: date)
        } else {
            baseTime = calculateBaseTimeForUltraSrtFcst(currentDate: date)
        }
        
        let parameters = [
            "serviceKey=\(apiKey)",
            "numOfRows=1000",
            "pageNo=1",
            "dataType=JSON",
            "base_date=\(baseDate)",
            "base_time=\(baseTime)",
            "nx=\(nx)",
            "ny=\(ny)"
        ].joined(separator: "&")

        return "\(baseURL)\(apiURL)?\(parameters)"
    }
    
    static func calculateBaseTimeForUltraSrtFcst(currentDate: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.hour, .minute], from: currentDate)

        if components.minute! < 30 {
            components.hour! -= 1
            components.minute = 59
        }
        return String(format: "%02d%02d", components.hour!, components.minute!)
    }

    static func calculateBaseTimeForVilageFcst(currentDate: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: currentDate)
        
        let baseHours = [2, 5, 8, 11, 14, 17, 20, 23]
        let lastBaseHour = baseHours.reversed().first { $0 <= components.hour! }!
        return String(format: "%02d00", lastBaseHour)
    }

}
