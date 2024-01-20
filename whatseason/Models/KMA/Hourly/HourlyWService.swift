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
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyyMMddHHmm"
        $0.timeZone = .current
        $0.locale = Locale(identifier: "ko")
    }
    
    private let KMA_API_KEY = Bundle.main.infoDictionary?["KMA_API_KEY"] as! String
    
    func fetchForecastData(date: Date, nx: Int, ny: Int) async -> [HourlyW]? {
        let requestURL = createRequestURL(date: date, nx: nx, ny: ny)
        guard let url = URL(string: requestURL) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
            return parseHourlyForecast(from: forecastResponse)
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func createRequestURL(date: Date, nx: Int, ny: Int) -> String {
        let calendar = Calendar.current
        var adjustedDate = date
        
        if calendar.component(.minute, from: date) < 30 {
            adjustedDate = calendar.date(byAdding: .hour, value: -1, to: date)!
            adjustedDate = calendar.date(bySetting: .minute, value: 59, of: adjustedDate)!
        }

        let dateTimeString = dateFormatter.string(from: adjustedDate)
        
        return "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?serviceKey=\(KMA_API_KEY)&numOfRows=1000&pageNo=1&dataType=JSON&base_date=\(dateTimeString.dropLast(4))&base_time=\(dateTimeString.suffix(4))&nx=\(nx)&ny=\(ny)"
    }
    
    func parseHourlyForecast(from response: ForecastResponse) -> [HourlyW]? {
        var forecastDict = [Date: HourlyW]()
        
        for item in response.response.body.items.item {
            guard let forecastDate = dateFormatter.date(from: "\(item.fcstDate)\(item.fcstTime)") else {
                continue
            }
            
            let value = item.fcstValue.trimmingCharacters(in: .whitespacesAndNewlines)
            var forecast = forecastDict[forecastDate] ?? HourlyW(
                date: forecastDate,
                temperature: nil,
                precipitation: nil,
                skyStatus: nil,
                rainType: nil,
                humidity: nil,
                windSpeed: nil,
                windDirection: nil
            )
            
            switch item.category {
            case "T1H":
                forecast.temperature = Double(value)
            case "RN1":
                forecast.precipitation = value // 강수량은 String 타입으로 처리
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
        
        // Dictionary를 Date 기준으로 정렬하여 배열로 변환
        let sortedForecasts = forecastDict.values.sorted(by: { $0.date < $1.date })
        return sortedForecasts
    }
    
}
