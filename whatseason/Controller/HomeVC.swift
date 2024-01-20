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
    let weatherKitservice = WeatherService()
    
    let currentWService = CurrentWService()
    let hourlyWService = HourlyWService()
    
    var anyW = AnyW(apple: nil, currentW: nil, hourlyW: [], address: "")
    let dispatchGroup = DispatchGroup()
    
    // 위치 정보를 불러왔는지 확인
    var hasReceivedLocationUpdate = false
    
    // 예보 데이터를 담을 배열
    var hourly: [HourlyW] = []
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
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLHeadingFilterNone
        
        // 날씨 데이터에 대한 권한 설정
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func getAllWeather(date: Date, x: Int, y: Int, loc: CLLocation, address: String) {
        // 기상청 날씨 데이터 요청
        dispatchGroup.enter()
        getKMACurrent(date, x, y)
        
        dispatchGroup.enter()
        getKMAHourly(date, x, y)
        
        // Apple 날씨 데이터 요청
        dispatchGroup.enter()
        getWeatherKit(loc)
        
        // 두 비동기 작업이 완료되면 UI 업데이트
        dispatchGroup.notify(queue: .main) {
            print("KMACurrent = \(self.anyW.currentW?.date ?? Date()) Temp: \(self.anyW.currentW?.temperature ?? 0)")
            print("KMAHourly = \(self.hourly.first?.date ?? Date()) Temp: \(self.hourly.first?.temperature ?? 0)")
            print("Apple = \(self.anyW.apple?.currentWeather.temperature.value ?? 0)")
            print("비동기 작업 종료")
            
            self.anyW.address = address
            self.updateFromAnyWeather(self.anyW, address)
        }
    }
    
    func getKMAHourly(_ date: Date, _ nx: Int, _ ny: Int) {
        Task {
            if let result = await hourlyWService.fetchForecastData(date: date, nx: nx, ny: ny) {
                DispatchQueue.main.async {
                    self.hourly = result
                    print("기상청 초단기예보를 불러왔습니다.")
                    
                    /*
                    테스트 프린트
                    for w in self.anyW.hourlyW {
                        guard let w = w else { return }
                        print("날짜: \(w.date.toFormattedKoreanString())\n\(String(describing: w.temperature)),\(String(describing: w.rainType)),\(String(describing: w.humidity)),\(String(describing: w.rainProbability)),\(String(describing: w.skyStatus)),\(String(describing: w.windSpeed)),\(String(describing: w.windDirection))")
                    }
                    */
                    
                    self.dispatchGroup.leave()
                }
            } else {
                print("기상청 초단기예보를 불러오는데에 실패했습니다.")
                self.dispatchGroup.leave()
            }
        }
    }
    
    func getKMACurrent(_ date: Date, _ nx: Int, _ ny: Int) {
        Task {
            if let result = await currentWService.fetchWeatherData(date: date, nx: nx, ny: ny) {
                DispatchQueue.main.async {
                    self.anyW.currentW = result
                    print("기상청 초단기실황을 불러왔습니다.")
                    self.dispatchGroup.leave()
                }
            } else {
                print("기상청 초단기실황을 불러오는데 실패했습니다.")
                self.dispatchGroup.leave()
            }
        }
    }
    
    /// 위치 정보와 도시명을 파라미터로 받아 애플 날씨 데이터를 불러옵니다.
    func getWeatherKit(_ location: CLLocation) {
        Task {
            do {
                let result = try await weatherKitservice.weather(for: location)
                
                /*
                // 예보 데이터를 배열에 담습니다.
                result.hourlyForecast.forecast.forEach { hourWeather in
                    self.hourly.append(hourWeather)
                }
                result.dailyForecast.forecast.forEach { dayWeather in
                    self.daily.append(dayWeather)
                }
                */
                
                self.anyW.apple = result
                print("애플 날씨 정보를 불러왔습니다.")
                self.dispatchGroup.leave()
                
            } catch {
                print("애플 날씨 정보를 불러오는데 실패했습니다.")
                print(String(describing: error))
                self.dispatchGroup.leave()
            }
        }
    }
    
    /// 날씨 데이터를 받아 화면을 업데이트합니다.
    func updateFromAnyWeather(_ w: AnyW, _ address: String) {
        // 날씨 데이터 전달
        homeView.configure(w, address)
        
        // 로티 배경 설정
        let lottieName = w.apple!.currentWeather.condition.conditionToLottieName()
        let lottieName2 = w.apple!.currentWeather.condition.conditionToLottieName2()
        homeView.addBackgroundLottie(lottieName, lottieName2)
        homeView.setUpView()
    }
}

// MARK: - 코어로케이션델리게이트
extension HomeVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !hasReceivedLocationUpdate else {
            return
        }
        
        hasReceivedLocationUpdate = true
        self.locationManager.stopUpdatingLocation()
        
        let location: CLLocation = locations[locations.count - 1]
        let longitude: CLLocationDegrees = location.coordinate.longitude
        let latitude: CLLocationDegrees = location.coordinate.latitude
        
        let converter: ConvertXY = ConvertXY()
        let (x, y): (Int, Int)
        = converter.convertGrid(lon: longitude, lat: latitude)
        
        
        let findLocation: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let geoCoder: CLGeocoder = CLGeocoder()
        let local: Locale = Locale(identifier: "Ko-kr") // Korea
        geoCoder.reverseGeocodeLocation(findLocation, preferredLocale: local) { (place, error) in
            if let address: [CLPlacemark] = place {
                print("(longitude, latitude) = (\(x), \(y))")
                let address = "\(address.last?.locality ?? "") \(address.last?.subLocality ?? "")"
                
                self.getAllWeather(date: Date(), x: x, y: y, loc: location, address: address)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
}
