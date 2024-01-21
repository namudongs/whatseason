//
//  MidKMAHelper.swift
//  whatseason
//
//  Created by namdghyun on 1/21/24.
//

import Foundation

class MidKMAHelper {
    static let shared = MidKMAHelper()
    
    func createRequestURL(apiURL: String, date: Date, regId: String) -> String {
        let baseURL = "http://apis.data.go.kr/1360000/MidFcstInfoService/"
        let apiKey = Bundle.main.infoDictionary?["KMA_API_KEY"] as! String
        
        let baseDate = calculateBaseDateForMidKMA(date)
        
        let parameters = [
            "serviceKey=\(apiKey)",
            "numOfRows=1000",
            "pageNo=1",
            "dataType=JSON",
            "regId=\(regId)",
            "tmFc=\(baseDate)"
        ].joined(separator: "&")
        
        
        return "\(baseURL)\(apiURL)?\(parameters)"
    }
    
    private func calculateBaseDateForMidKMA(_ date: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        var baseDate = Date()
        
        if hour < 6 {
            baseDate = calendar.date(bySettingHour: 18, minute: 0, second: 0, of: date)!
            baseDate = calendar.date(byAdding: .day, value: -1, to: baseDate)!
        } else if hour >= 18 {
            baseDate = calendar.date(bySettingHour: 18, minute: 0, second: 0, of: date)!
        } else {
            baseDate = calendar.date(bySettingHour: 6, minute: 0, second: 0, of: date)!
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        let baseDateString = dateFormatter.string(from: baseDate)
        
        return baseDateString
    }

}
