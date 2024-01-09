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
    func getWeather(_ location: CLLocation, _ city: String) {
        Task {
            do {
                let result = try await service.weather(for: location)
                
                result.hourlyForecast.forecast.forEach { hourWeather in
                    self.hourly.append(hourWeather)
                }
                result.dailyForecast.forecast.forEach { dayWeather in
                    self.daily.append(dayWeather)
                }
                updateWeatherView(result, city)
                
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    /// 날씨 데이터를 받아 화면을 업데이트합니다.
    func updateWeatherView(_ result: Weather, _ city: String) {
        weatherView.configure(with: result, city: city)
        weatherView.tableView.reloadData()
    }
    
    /// Date 데이터를 설정합니다.
    func convertDate(_ to: Date) -> String {
        let df = DateFormatter()
        df.timeZone = .current
        df.locale = Locale(identifier: "ko")
        df.dateFormat = "E요일"
        return df.string(from: to)
    }
    
    /// 테이블뷰의 Identifier와 Datasource를 설정합니다.
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
    ) { guard let location = locations.first else { return }
        locationManager.stopUpdatingLocation()
        
        // 위치 정보로 도시명을 받아 날씨 데이터 파싱
        location.fetchCity { city, error in
            guard let city = city, error == nil else { return }
            self.getWeather(location, city)
        }
    }
}

// MARK: - 테이블뷰데이터소스
extension WeatherVC: UITableViewDataSource {
    
    // Row 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        daily.count
    }
    
    // Cell 업데이트
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell", for: indexPath) as! DailyCell
        
        let dayWeather = daily[indexPath.row]
        let date = convertDate(dayWeather.date)
        cell.dateLabel.text = "\(date)"
        cell.lowTempLable.text = "\(Int(dayWeather.lowTemperature.value.rounded()))"
        cell.highTempLable.text = "\(Int(dayWeather.highTemperature.value.rounded()))"
        return cell
    }
}
