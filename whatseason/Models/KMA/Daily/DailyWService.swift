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
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyyMMddHHmm"
        $0.timeZone = TimeZone(identifier: "Asia/Seoul")
        $0.locale = Locale(identifier: "ko_KR")
    }
    
    private let KMA_API_KEY = Bundle.main.infoDictionary?["KMA_API_KEY"] as! String
    
    func fetchForecastData(date: Date, nx: Int, ny: Int) async -> [DailyW]? {
        let requestURL = createRequestURL(date: date, nx: nx, ny: ny)
        guard let url = URL(string: requestURL) else { return nil }
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
            return parseDailyForecast(from: forecastResponse)
        } catch {
            print(error)
            return nil
        }
    }
    
    func createRequestURL(date: Date, nx: Int, ny: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        let baseDate = dateFormatter.string(from: date)
        let baseTime = 2000
        
        let requestURL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst" +
        "?serviceKey=\(KMA_API_KEY)&numOfRows=1000&pageNo=1&dataType=JSON&base_date=\(baseDate.dropLast(4))&base_time=\(baseTime)&nx=\(nx)&ny=\(ny)"
        return requestURL
    }
    
    func parseDailyForecast(from response: ForecastResponse) -> [DailyW]? {
        var forecastsDict = [String: DailyW]()
        
        for item in response.response.body.items.item {
            let dateKey = "\(item.fcstDate)\(item.fcstTime)"
            var forecast = forecastsDict[dateKey] ?? DailyW(date: dateFromStrings(date: item.fcstDate, time: item.fcstTime),
                                                            hourlyTemp: nil,
                                                            dailyHighTemp: nil,
                                                            dailyLowTemp: nil,
                                                            precipitation: nil,
                                                            rainProbability: nil,
                                                            snowProbability: nil,
                                                            skyStatus: nil,
                                                            rainType: nil,
                                                            humidity: nil,
                                                            windSpeed: nil,
                                                            windDirection: nil)
            
            switch item.category {
            case "TMP":
                forecast.hourlyTemp = Double(item.fcstValue)
            case "TMX":
                forecast.dailyHighTemp = Double(item.fcstValue)
            case "TMN":
                forecast.dailyLowTemp = Double(item.fcstValue)
            case "PCP":
                forecast.precipitation = item.fcstValue
            case "POP":
                forecast.rainProbability = item.fcstValue
            case "SNO":
                forecast.snowProbability = item.fcstValue
            case "SKY":
                forecast.skyStatus = Int(item.fcstValue)
            case "PTY":
                forecast.rainType = Int(item.fcstValue)
            case "REH":
                forecast.humidity = Int(item.fcstValue)
            case "WSD":
                forecast.windSpeed = Double(item.fcstValue)
            case "VEC":
                forecast.windDirection = Int(item.fcstValue)
            default:
                break
            }
            
            forecastsDict[dateKey] = forecast
        }
        
        let sortedForecasts = forecastsDict.values.sorted(by: { $0.date < $1.date })
        return sortedForecasts
    }
    
    private func dateFromStrings(date: String, time: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return dateFormatter.date(from: "\(date)\(time)")!
    }
    
}
