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
    var weatherView = WeatherView()
    let locationManager = CLLocationManager()
    
    let service = WeatherService()
    var hourly: [HourWeather] = []
    var daily: [DayWeather] = []
    
    
    override func loadView() {
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
        setUpTableView()
    }
    
    // MARK: - 위치 및 날씨 설정
    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func getWeather(
        location: CLLocation,
        city: String
    ) {
        Task {
            do {
                let result = try await service.weather(
                    for: location
                )
                //                let current = result.currentWeather
                //                print("Current: \n"+String(describing: result.currentWeather))
                //                print("Daily: \n"+String(describing: result.dailyForecast))
                //                print("Hourly: \n"+String(describing: result.hourlyForecast))
                //                print("Minutely: \n"+String(describing: result.minuteForecast))
                
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
    
    func setUpTableView() {
        weatherView.tableView.register(
            DailyCell.self,
            forCellReuseIdentifier: "dailyCell"
        )
        weatherView.tableView.dataSource = self
    }
}

extension WeatherVC: CLLocationManagerDelegate {
    // MARK: - 코어로케이션델리게이트
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else {
            return
        }
        locationManager.stopUpdatingLocation()
        
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

extension WeatherVC: UITableViewDataSource {
    // MARK: - 테이블뷰데이터소스
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        daily.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "dailyCell",
            for: indexPath
        ) as! DailyCell
        
        print(daily.count)
        let dayWeather = daily[indexPath.row]
        cell.dateLabel.text = "\(dayWeather.date)"
        cell.lowTempLable.text = "\(dayWeather.lowTemperature)"
        cell.highTempLable.text = "\(dayWeather.highTemperature)"
        return cell
    }
}
