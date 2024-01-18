//
//  KMAWeatherService.swift
//  whatseason
//
//  Created by namdghyun on 1/19/24.
//
import UIKit
import WeatherKit

class KMACurrentWeatherService {
    
    private let urlSession = URLSession.shared
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyyMMddHHmm"
    }
    
    let KMA_API_KEY = Bundle.main.infoDictionary?["KMA_API_KEY"] as! String
    
    func fetchWeatherData(date: Date, nx: Int, ny: Int) async -> KMACurrentWeather? {
        let requestURL = createRequestURL(date: date, nx: nx, ny: ny)
        print(requestURL)
        guard let url = URL(string: requestURL) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return parseCurrentWeather(from: weatherResponse)
        } catch {
            // 에러 처리
            print("Error: \(error)")
            return nil
        }
    }
    
    private func createRequestURL(date: Date, nx: Int, ny: Int) -> String {
        let calendar = Calendar.current
        var adjustedDate = date
        
        if calendar.component(.minute, from: date) < 30 {
            // 이전 시간의 마지막 분(59분)으로 조정
            adjustedDate = calendar.date(byAdding: .hour, value: -1, to: date)!
            adjustedDate = calendar.date(bySetting: .minute, value: 59, of: adjustedDate)!
        }

        let dateTimeString = dateFormatter.string(from: adjustedDate)
        return "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=\(KMA_API_KEY)&numOfRows=10&pageNo=1&dataType=JSON&base_date=\(dateTimeString.dropLast(4))&base_time=\(dateTimeString.suffix(4))&nx=\(nx)&ny=\(ny)"
    }

    
    private func parseCurrentWeather(from response: WeatherResponse) -> KMACurrentWeather? {
        guard let lastItem = response.response.body.items.item.last,
              let lastDate = dateFormatter.date(from: "\(lastItem.baseDate)\(lastItem.baseTime)") else {
            return nil
        }
        
        var weatherDict = [String: String]()
        response.response.body.items.item.forEach { item in
            weatherDict[item.category] = item.obsrValue
        }
        
        return KMACurrentWeather(
            date: lastDate,
            temperature: Double(weatherDict["T1H"] ?? "") ?? 0.0,
            precipitation: Int(weatherDict["RN1"] ?? "") ?? 0,
            rainType: Int(weatherDict["PTY"] ?? "") ?? 0,
            humidity: Int(weatherDict["REH"] ?? "") ?? 0,
            windSpeed: Double(weatherDict["WSD"] ?? "") ?? 0.0,
            windDirection: Int(weatherDict["VEC"] ?? "") ?? 0
        )
    }
}
