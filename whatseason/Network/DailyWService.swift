//
//  DailyWService.swift
//  whatseason
//
//  Created by namdghyun on 1/20/24.
//

import Foundation

// MARK: - 단기예보
class DailyWService {
    private let urlSession = URLSession.shared
    
    func fetchW(date: Date, nx: Int, ny: Int) async -> [DailyW]? {
        let requestURL = ShortKMAHelper.shared.createRequestURL(apiURL: "getVilageFcst", date: date, nx: nx, ny: ny)
        
        do {
            let (data, _) = try await urlSession.data(from: URL(string: requestURL)!)
            let response = try JSONDecoder().decode(WResponse.self, from: data)
            return parseW(from: response)
        } catch {
            print(error)
            return nil
        }
    }
    
    private func parseW(from response: WResponse) -> [DailyW]? {
        var forecastsDict = [String: DailyW]()
        
        for item in response.response.body.items.item {
            let dateKey = "\(item.fcstDate!)\(item.fcstTime!)"
            let value = item.fcstValue!.trimmingCharacters(in: .whitespacesAndNewlines)
            let df = ShortKMAHelper.shared.createFormatter()
            let date = df.date(from: "\(item.fcstDate!)\(item.fcstTime!)")
            var forecast = forecastsDict[dateKey] ?? DailyW(date: date!)
            
            switch item.category {
            case "TMP":
                forecast.hourlyTemp = Double(value)
            case "TMX":
                forecast.dailyHighTemp = Double(value)
            case "TMN":
                forecast.dailyLowTemp = Double(value)
            case "PCP":
                forecast.precipitation = value
            case "POP":
                forecast.rainProbability = value
            case "SNO":
                forecast.snowProbability = value
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
            
            forecastsDict[dateKey] = forecast
        }
        
        let sortedForecasts = forecastsDict.values.sorted(by: { $0.date < $1.date })
        return sortedForecasts
    }
}
