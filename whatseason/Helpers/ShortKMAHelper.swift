//
//  KMAHelper.swift
//  whatseason
//
//  Created by namdghyun on 1/20/24.
//

import Foundation

class ShortKMAHelper {
    static let shared = ShortKMAHelper()
    
    func createFormatter(timeZone: TimeZone = .current, locale: Locale = Locale(identifier: "ko")) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmm"
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter
    }
    
    func createRequestURL(apiURL: String, date: Date, nx: Int, ny: Int) -> String {
        // 초단기실황    http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst
        // 초단기예보    http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst
        // 단기예보     http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst
        
        let baseURL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/"
        let apiKey = Bundle.main.infoDictionary?["KMA_API_KEY"] as! String
        
        let dateFormatter = createFormatter(timeZone: TimeZone(identifier: "Asia/Seoul")!)
        var baseDate = String(dateFormatter.string(from: date).dropLast(4))
        var baseTime = "0000"
        
        if apiURL == "getUltraSrtFcst" {
            baseTime = calculateBaseTimeForUltraSrt(currentDate: date)
        } else if apiURL == "getVilageFcst" {
            baseTime = calculateBaseTimeForVilageFcst(currentDate: date)
            baseDate = calculateBaseDateForVilageFcst(date: date, basetime: baseTime, dateFormatter: dateFormatter)
        } else {
            baseTime = calculateBaseTimeForUltraSrt(currentDate: date)
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
    
    private func calculateBaseDateForVilageFcst(date: Date, basetime: String, dateFormatter: DateFormatter) -> String {
        var baseDate = dateFormatter.string(from: date).dropLast(4)
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.hour, .minute], from: date)
        if components.hour! < 2 || (components.hour! >= 2 && components.hour! < 5) {
            let yesterday = calendar.date(byAdding: .day, value: -1, to: date)!
            baseDate = dateFormatter.string(from: yesterday).dropLast(4)
        }
        
        return String(baseDate)
    }
    
    private func calculateBaseTimeForUltraSrt(currentDate: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.hour, .minute], from: currentDate)
        
        if components.minute! < 30 {
            components.hour! -= 1
            components.minute = 59
        }
        return String(format: "%02d%02d", components.hour!, components.minute!)
    }
    
    private func calculateBaseTimeForVilageFcst(currentDate: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.hour], from: currentDate)
        let baseHours = [2, 5, 8, 11, 14, 17, 20, 23]
        var baseHour = 23 // 기본값으로 이전 날의 마지막 base hour 설정

        if let hour = components.hour {
            if hour >= 2 {
                // 현재 시간이 2시 이상이면, 현재 시간보다 작거나 같은 가장 가까운 시간을 찾기
                baseHour = baseHours.last { $0 <= hour } ?? baseHours.last!
            }
        }

        return String(format: "%02d00", baseHour)
    }
}
