//
//  ViewController.swift
//  whatseason
//
//  Created by namdghyun on 1/2/24.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    let locationManager = CLLocationManager()
    var locationModel = LocationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        configureLocationManager()
        
    }
    
    func configureLocationManager() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthorizationStatus()
        }
    
    func checkLocationAuthorizationStatus() {
            
        // 3.1
        guard CLLocationManager.locationServicesEnabled() else {
            // 시스템 설정으로 유도하는 커스텀 얼럿
            showRequestLocationServiceAlert()
            return
        }
            
            
        // 3.2
        let authorizationStatus: CLAuthorizationStatus
            
        // 앱의 권한 상태 가져오는 코드 (iOS 버전에 따라 분기처리)
        if #available(
            iOS 14.0,
            *
        ) {
            authorizationStatus = locationManager.authorizationStatus
        }else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // 권한 상태값에 따라 분기처리를 수행하는 메서드 실행
        updateBasedOnAuthorizationStatus(
            authorizationStatus
        )
    }
    
    func updateBasedOnAuthorizationStatus(
        _ status: CLAuthorizationStatus
    ) {
        locationModel.updateAuthorizationStatus(
            status
        )
        switch status {
        case .notDetermined:
            // 사용자가 권한에 대한 설정을 선택하지 않은 상태
            
            // 권한 요청을 보내기 전에 desiredAccuracy 설정 필요
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            // 권한 요청을 보낸다.
            locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            // 사용자가 명시적으로 권한을 거부했거나, 위치 서비스 활성화가 제한된 상태
            // 시스템 설정에서 설정값을 변경하도록 유도한다.
            // 시스템 설정으로 유도하는 커스텀 얼럿
            showRequestLocationServiceAlert()
            
        case .authorizedWhenInUse:
            // 앱을 사용중일 때, 위치 서비스를 이용할 수 있는 상태
            // manager 인스턴스를 사용하여 사용자의 위치를 가져온다.
            locationManager.startUpdatingLocation()
            
        default:
            print(
                "Default"
            )
        }
        }
    
    // 시스템 설정으로 유도하는 커스텀 얼럿
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(
            title: "위치 정보 이용",
            message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.",
            preferredStyle: .alert
        )
        let goSetting = UIAlertAction(
            title: "설정으로 이동",
            style: .destructive
        ) { _ in
            if let appSetting = URL(
                string: UIApplication.openSettingsURLString
            ) {
                UIApplication.shared.open(
                    appSetting
                )
            }
        }
        let cancel = UIAlertAction(
            title: "취소",
            style: .default
        ) { [weak self] _ in
            //            async { await self?.reloadData() }
            self?.reloadData()
        }
        requestLocationServiceAlert.addAction(
            cancel
        )
        requestLocationServiceAlert.addAction(
            goSetting
        )
        
        present(
            requestLocationServiceAlert,
            animated: true
        )
    }
    
    func reloadData() {
        // 기본 위치 서울로 설정
        locationModel.currentLocation = CLLocation(
            latitude: 37.5665,
            longitude: 126.9780
        )
    }
    
}

extension LocationViewController: CLLocationManagerDelegate {
    
    // 사용자의 위치를 성공적으로 가져왔을 때 호출
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        
        // 위치 정보를 배열로 입력받는데, 마지막 index값이 가장 정확하다고 한다.
        if let coordinate = locations.last?.coordinate {
            // ⭐️ 사용자 위치 정보 사용
            locationModel.currentLocation =
            CLLocation(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            )
        }
        // startUpdatingLocation()을 사용하여 사용자 위치를 가져왔다면
        // 불필요한 업데이트를 방지하기 위해 stopUpdatingLocation을 호출
        locationManager.stopUpdatingLocation()
    }
    
    
    
    
    // 사용자가 GPS 사용이 불가한 지역에 있는 등 위치 정보를 가져오지 못했을 때 호출
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(
            #function
        )
    }
    
    
    
    
    // 앱에 대한 권한 설정이 변경되면 호출 (iOS 14 이상)
    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
        checkLocationAuthorizationStatus()
    }
    
    // 앱에 대한 권한 설정이 변경되면 호출 (iOS 14 미만)
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
        checkLocationAuthorizationStatus()
    }
}
