//
//  DailyCell.swift
//  whatseason
//
//  Created by namdghyun on 1/4/24.
//

import UIKit
import WeatherKit
import Then
import SnapKit

class DailyCell: UITableViewCell {
    let dateLabel = UILabel().then {
        $0.text = "날짜"
    }
    let lowTempLable = UILabel().then {
        $0.text = "0°C"
    }
    let highTempLable = UILabel().then {
        $0.text = "0°C"
    }
    let stack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        
        setUpView() // setUpView 호출 추가
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    func setUpView() {
        addSubview(
            stack
        )
        stack.addArrangedSubview(
            dateLabel
        )
        stack.addArrangedSubview(
            lowTempLable
        )
        stack.addArrangedSubview(
            highTempLable
        )
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}