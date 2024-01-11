//
//  String+Extension.swift
//  whatseason
//
//  Created by namdghyun on 1/11/24.
//

import Foundation

extension Date {
    /// Date 데이터를 설정합니다.
    func toFormattedKoreanString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "M월 d일 H시 m분"
        return dateFormatter.string(from: self)
    }
}
