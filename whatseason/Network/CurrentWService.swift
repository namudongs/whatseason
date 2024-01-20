//
//  CurrentWService.swift
//  whatseason
//
//  Created by namdghyun on 1/19/24.
//

import Foundation
import WeatherKit

// MARK: - 초단기실황
class CurrentWService {
    private let urlSession = URLSession.shared
    
    func fetchW(date: Date, nx: Int, ny: Int) async -> CurrentW? {
        let requestURL = KMAHelper.createRequestURL(apiURL: "getUltraSrtNcst", date: date, nx: nx, ny: ny)
        
        do {
            let data = try await NetworkHelper.shared.fetchData(from: requestURL)
            let response = try JSONDecoder().decode(WResponse.self, from: data)
            return parseW(from: response)
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    private func parseW(from response: WResponse) -> CurrentW? {
        guard let lastItem = response.response.body.items.item.last else {
            return nil
        }
        
        let baseDate = lastItem.baseDate
        let baseTime = lastItem.baseTime
        let df = KMAHelper.createFormatter()
        let lastDate = df.date(from: "\(baseDate)\(baseTime)") ?? Date()
        
        var weatherDict = [String: String]()
        response.response.body.items.item.forEach { item in
            if let obsrValue = item.obsrValue {
                weatherDict[item.category] = obsrValue
            }
        }
        
        let temperature = Double(weatherDict["T1H"] ?? "0") ?? 0.0
        let precipitation = Double(weatherDict["RN1"] ?? "0") ?? 0.0
        let rainType = Int(weatherDict["PTY"] ?? "0") ?? 0
        let humidity = Int(weatherDict["REH"] ?? "0") ?? 0
        let windSpeed = Double(weatherDict["WSD"] ?? "0") ?? 0.0
        let windDirection = Int(weatherDict["VEC"] ?? "0") ?? 0
        
        return CurrentW(
            date: lastDate,
            temperature: temperature,
            precipitation: precipitation,
            rainType: rainType,
            humidity: humidity,
            windSpeed: windSpeed,
            windDirection: windDirection
        )
    }
    
}

