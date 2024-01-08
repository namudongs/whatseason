//
//  WeatherVC.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import CoreLocation
import WeatherKit
import UIKit

class WeatherVC: UIViewController {
    
    // MARK: - 프로퍼티
    var weatherView = WeatherView()
    let locationManager = CLLocationManager()
    let service = WeatherService()
    
    // 예보 데이터를 담을 배열
    var hourly: [HourWeather] = []
    var daily: [DayWeather] = []
    
    // MARK: - 라이프사이클
    override func loadView() {
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
        setUpTableView()
    }
    
    // MARK: - 메서드
    /// 유저에게 위치 정보 권한을 요청하고 위치 정보를 불러옵니다.
    func getUserLocation() {
        // 날씨 데이터에 대한 권한 설정
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    /// 위치 정보와 도시명을 파라미터로 받아 날씨 데이터를 불러옵니다.
    func getWeather(
        location: CLLocation,
        city: String
    ) {
        Task {
            do {
                let result = try await service.weather(
                    for: location
                )
                
                result.hourlyForecast.forecast.forEach { hourWeather in
                    self.hourly.append(
                        hourWeather
                    )
                }
                result.dailyForecast.forecast.forEach { dayWeather in
                    self.daily.append(
                        dayWeather
                    )
                }
                
                // 뷰 업데이트
                weatherView.configure(
                    with: result,
                    city: city
                )
                weatherView.tableView.reloadData()
                
            } catch {
                print(
                    String(
                        describing: error
                    )
                )
            }
        }
    }
    
    /// Date 데이터를 설정합니다.
    func converDate(_ to: Date) -> String {
        let df = DateFormatter()
        df.timeZone = .current
        df.locale = Locale(identifier: "ko")
        df.dateFormat = "M월 d일 E요일"
        return df.string(from: to)
    }
    
    /// 테이블뷰의 identifier와 datasource를 설정합니다.
    func setUpTableView() {
        weatherView.tableView.register(
            DailyCell.self,
            forCellReuseIdentifier: "dailyCell"
        )
        weatherView.tableView.dataSource = self
    }
}

// MARK: - 코어로케이션델리게이트
extension WeatherVC: CLLocationManagerDelegate {
    
    // 위치 정보가 업데이트되면 호출
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else {
            return
        }
        locationManager.stopUpdatingLocation()
        
        // 위치 정보로 도시명을 받아 날씨 데이터 파싱
        location.fetchCity {
            city,
            error in
            guard let city = city,
                  error == nil else {
                return
            }
            self.getWeather(
                location: location,
                city: city
            )
        }
    }
}

// MARK: - 테이블뷰데이터소스
extension WeatherVC: UITableViewDataSource {
    
    // 셀 행 개수 업데이트
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        daily.count
    }
    
    // 셀 내용 업데이트
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "dailyCell",
            for: indexPath
        ) as! DailyCell
        
        let dayWeather = daily[indexPath.row]
        let date = converDate(dayWeather.date)
        cell.dateLabel.text = "\(date)"
        cell.lowTempLable.text = "\(Int(dayWeather.lowTemperature.value.rounded()))"
        cell.highTempLable.text = "\(Int(dayWeather.highTemperature.value.rounded()))"
        return cell
    }
}
