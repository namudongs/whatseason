//
//  WeatherViewController.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import CoreLocation
import WeatherKit
import UIKit

class WeatherViewController: UIViewController {
    
    var weatherView = WeatherView()
    var locationManager = LocationManager()
    
    var weatherKit: Weather?
    var currentCityName = ""
    
    override func loadView() {
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocationAndWeather()
    }
    
    // MARK: - 위치 및 날씨 설정
    func setUpLocationAndWeather() {
        locationManager.fetchLocation {
            [weak self] location,
            error in
            guard let self = self else {
                return
            }
            
            if let location = location {
                self.fetchWeatherAndCityName(
                    location: CLLocation(
                        latitude: location.latitude,
                        longitude: location.longitude
                    )
                )
            } else {
                self.fetchWeatherAndCityName(
                    location: defaultLocation
                )
            }
        }
    }
    
    func fetchWeatherAndCityName(
        location: CLLocation
    ) {
        fetchWeather(
            location: location
        )
        convertCoordinatesToCityName(
            location: location
        )
    }
    
    func fetchWeather(
        location: CLLocation
    ) {
        Task {
            do {
                let weather = try await WeatherService.shared.weather(
                    for: location
                )
                DispatchQueue.main.async {
                    self.weatherKit = weather
                    self.updateWeatherView()
                }
            } catch {
                print(
                    "Weather fetch error: \(error)"
                )
                // 여기에 사용자에게 오류 메시지를 표시하는 코드를 추가할 수 있습니다.
            }
        }
    }
    
    func convertCoordinatesToCityName(
        location: CLLocation
    ) {
        // LocationManager의 convertCoordinatesToCityName 메서드 구현을 사용
        locationManager.convertCoordinatesToCityName(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            completion: {
                [weak self] result in
                guard let cityName = result else {
                    return
                }
                DispatchQueue.main.async {
                    self?.currentCityName = cityName
                    self?.updateWeatherView()
                }
            }
        )
    }

    // MARK: - 날씨 뷰 업데이트
    func updateWeatherView() {
        weatherView.mainLabel.text = currentCityName
        weatherView.temperatureLabel.text = "\(weatherKit?.currentWeather.temperature.value ?? 0.0)"
        weatherView.humidityLabel.text = "\(weatherKit?.currentWeather.humidity.rounded() ?? 0.0)"
        
    }
}
