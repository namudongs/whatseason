//
//  HourlyWService.swift
//  whatseason
//
//  Created by namdghyun on 1/20/24.
//

import Foundation

// MARK: - 초단기예보
class HourlyWService {
    private let urlSession = URLSession.shared
    
    func fetchW(date: Date, nx: Int, ny: Int) async -> [HourlyW]? {
        let requestURL = ShortKMAHelper.shared.createRequestURL(apiURL: "getUltraSrtFcst", date: date, nx: nx, ny: ny)
        
        do {
            let (data, _) = try await urlSession.data(from: URL(string: requestURL)!)
            let response = try JSONDecoder().decode(WResponse.self, from: data)
            return parseW(from: response)
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    private func parseW(from response: WResponse) -> [HourlyW]? {
        var forecastDict = [Date: HourlyW]()
        
        for item in response.response.body.items.item {
            let df = ShortKMAHelper.shared.createFormatter()
            guard let forecastDate = df.date(from: "\(item.fcstDate!)\(item.fcstTime!)") else {
                continue
            }
            
            let value = item.fcstValue!.trimmingCharacters(in: .whitespacesAndNewlines)
            var forecast = forecastDict[forecastDate] ?? HourlyW(date: forecastDate)
            
            switch item.category {
            case "T1H":
                forecast.temperature = Double(value)
            case "RN1":
                forecast.precipitation = value
            case "SKY":
                forecast.skyStatus = Int(value)
            case "PTY":
                forecast.rainType = Int(value)
            case "REH":
                forecast.humidity = Int(value)
            case "WSD":
                forecast.windSpeed = Double(value)
            case "VEC":
                forecast.windDirection = Int(value)
            default:
                break
            }
            
            forecastDict[forecastDate] = forecast
        }
        
        let sortedForecasts = forecastDict.values.sorted(by: { $0.date < $1.date })
        return sortedForecasts
    }
    
}
