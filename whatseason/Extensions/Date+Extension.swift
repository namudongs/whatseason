//
//  String+Extension.swift
//  whatseason
//
//  Created by namdghyun on 1/11/24.
//

import Foundation

extension Date {
    /// Date 데이터를 설정해 문자열로 반환합니다.
    func toFormattedKoreanString(_ dateFormat: String = "M월 d일 H시 m분") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    /// 현재 날짜에 특정 일수를 더합니다.
        func adding(days: Int) -> Date {
            let calendar = Calendar.current
            return calendar.date(byAdding: .day, value: days, to: self) ?? self
        }
}
