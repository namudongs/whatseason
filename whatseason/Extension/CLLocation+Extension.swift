//
//  CLLocation+Extension.swift
//  whatseason
//
//  Created by namdghyun on 1/4/24.
//

import UIKit
import CoreLocation

extension CLLocation {
    func fetchCity(completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $1)}
    }
}
