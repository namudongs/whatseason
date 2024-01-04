//
//  WeatherVC.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import CoreLocation
import WeatherKit
import UIKit

class WeatherVC: UIViewController, CLLocationManagerDelegate {
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
    }
    
    // MARK: - 위치 및 날씨 설정
    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func getWeather(location: CLLocation, city: String) {
        Task {
            do {
                let result = try await service.weather(for: location)
                let current = result.currentWeather
//                print("Current: \n"+String(describing: result.currentWeather))
//                print("Daily: \n"+String(describing: result.dailyForecast))
//                print("Hourly: \n"+String(describing: result.hourlyForecast))
//                print("Minutely: \n"+String(describing: result.minuteForecast))
                
                result.hourlyForecast.forecast.forEach { hourWeather in
                    self.hourly.append(hourWeather)
                }
                result.dailyForecast.forecast.forEach { dayWeather in
                    self.daily.append(dayWeather)
                }
                weatherView.configure(with: result, city: city)
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        locationManager.stopUpdatingLocation()
        
        location.fetchCity { city, error in
            guard let city = city, error == nil else { return }
            self.getWeather(location: location, city: city)
        }
    }

    // MARK: - 날씨 뷰 업데이트
    func updateWeatherView() {
        
    }
}
