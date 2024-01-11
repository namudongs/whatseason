//
//  HomeVC.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import CoreLocation
import WeatherKit
import UIKit

class HomeVC: UIViewController {
    
    // MARK: - 프로퍼티
    var homeView = HomeView()
    let locationManager = CLLocationManager()
    let service = WeatherService()
    
    // 예보 데이터를 담을 배열
    var hourly: [HourWeather] = []
    var daily: [DayWeather] = []
    
    // MARK: - 라이프사이클
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
    }
    
    // MARK: - 메서드
    /// 유저에게 위치 정보 권한을 요청하고 위치 정보를 불러옵니다.
    func getUserLocation() {
        // 날씨 데이터에 대한 권한 설정
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    /// 위치 정보와 도시명을 파라미터로 받아 애플 날씨 데이터를 불러옵니다.
    func getAppleWeather(_ location: CLLocation, _ city: String) {
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
        let currentWeather = result.currentWeather
        
        let date = currentWeather.date.toFormattedKoreanString()
        homeView.configure(result, city, date)
//        let lottieName = currentWeather.condition.conditionToLottieName()
//        homeView.addBackgroundLottie(lottieName)
        homeView.addBackgroundLottie("spring-bg")
        homeView.homeMainView.addWeatherLottie("clear-day")
        
        homeView.setUpView()
    }
}

// MARK: - 코어로케이션델리게이트
extension HomeVC: CLLocationManagerDelegate {
    
    // 위치 정보가 업데이트되면 호출
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) { guard let location = locations.first else { return }
        locationManager.stopUpdatingLocation()
        
        // 위치 정보로 도시명을 받아 애플 날씨 데이터 파싱
        location.fetchCity { city, error in
            guard let city = city, error == nil else { return }
            self.getAppleWeather(location, city)
        }
    }
}
