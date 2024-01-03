//
//  LocationManager.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    // MARK: - Properties

    private let locationManager = CLLocationManager()
    
    var locationStatus: CLAuthorizationStatus?
    
    var onLocationChange: ((CLLocation?) -> Void)?
    var onAuthStatusChange: ((CLAuthorizationStatus?) -> Void)?
    
    private var lastLocation: CLLocation?
    private var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func startLocationManagerIfNeeded() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        print(#function, statusString)
        onAuthStatusChange?(status)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        print(#function, location)
        onLocationChange?(location)
    }
}
