//
//  WeeklyWService.swift
//  whatseason
//
//  Created by namdghyun on 1/21/24.
//

import Foundation

class WeeklyWService {
    private let urlSession = URLSession.shared
    
    func fetchW(date: Date, regId: String, stnId: String, groupRegId: String) async -> [WeeklyW]? {
        let requestURL1 = MidKMAHelper.shared.createRequestURL(apiURL: "getMidLandFcst", date: date, regId: groupRegId)
        let requestURL2 = MidKMAHelper.shared.createRequestURL(apiURL: "getMidTa", date: date, regId: regId)
        
        do {
            let data = try await NetworkHelper.shared.fetchData(from: requestURL1)
            let data2 = try await NetworkHelper.shared.fetchData(from: requestURL2)
            let response = try JSONDecoder().decode(WResponse.self, from: data)
            let response2 = try JSONDecoder().decode(WResponse.self, from: data2)
            
            let forecast = parseW(from: response, baseDate: date)
            let temp = parseT(from: response2, baseDate: date)
            
            let combined = zip(forecast, temp).map { (fore, temp) -> WeeklyW in
                return WeeklyW(
                    date: fore.date,
                    highTemp: temp.highTemp,
                    lowTemp: temp.lowTemp,
                    rainProbabilityAM: fore.rainProbabilityAM,
                    rainProbabilityPM: fore.rainProbabilityPM,
                    conditionAM: fore.conditionAM,
                    conditionPM: fore.conditionPM
                )
            }
            
            return combined
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    private func parseT(from response: WResponse, baseDate: Date) -> [WeeklyW] {
        var weeklyTemp: [WeeklyW] = []
        let calendar = Calendar.current
        
        guard let item = response.response.body.items.item.first else { return [] }
        
        for i in 3...10 {
            guard let tempDate = calendar.date(byAdding: .day, value: i, to: baseDate) else { continue }
            
            let mirror = Mirror(reflecting: item)
            let suffix = "\(i)"
            
            let minTemp = mirror.children.first(where: { $0.label == "taMin\(suffix)" })?.value as? Int
            let maxTemp = mirror.children.first(where: { $0.label == "taMax\(suffix)" })?.value as? Int
            
            let temp = WeeklyW(
                date: tempDate,
                highTemp: maxTemp,
                lowTemp: minTemp,
                rainProbabilityAM: nil,
                rainProbabilityPM: nil,
                conditionAM: nil,
                conditionPM: nil
            )
            weeklyTemp.append(temp)
        }
        
        return weeklyTemp
    }
    
    
    private func parseW(from response: WResponse, baseDate: Date) -> [WeeklyW] {
        var weeklyForecast: [WeeklyW] = []
        let calendar = Calendar.current
        
        guard let item = response.response.body.items.item.first else { return [] }
        
        for i in 3...10 {
            guard let forecastDate = calendar.date(byAdding: .day, value: i, to: baseDate) else { continue }
            
            let mirror = Mirror(reflecting: item)
            let suffix = "\(i)"
            
            var rainProbabilityAM = mirror.children.first(where: { $0.label == "rnSt\(suffix)Am" })?.value as? Int
            var rainProbabilityPM = mirror.children.first(where: { $0.label == "rnSt\(suffix)Pm" })?.value as? Int
            var conditionAM = mirror.children.first(where: { $0.label == "wf\(suffix)Am" })?.value as? String
            var conditionPM = mirror.children.first(where: { $0.label == "wf\(suffix)Pm" })?.value as? String
            
            if i >= 8 {
                rainProbabilityAM = mirror.children.first(where: { $0.label == "rnSt\(suffix)" })?.value as? Int
                rainProbabilityPM = mirror.children.first(where: { $0.label == "rnSt\(suffix)" })?.value as? Int
                conditionAM = mirror.children.first(where: { $0.label == "wf\(suffix)" })?.value as? String
                conditionPM = mirror.children.first(where: { $0.label == "wf\(suffix)" })?.value as? String
            }
            
            let forecast = WeeklyW(
                date: forecastDate,
                highTemp: nil,
                lowTemp: nil,
                rainProbabilityAM: rainProbabilityAM,
                rainProbabilityPM: rainProbabilityPM,
                conditionAM: conditionAM,
                conditionPM: conditionPM
            )
            weeklyForecast.append(forecast)
        }
        
        return weeklyForecast
    }
    
    
}
