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
    
    // MARK: - 프로퍼티
    let icon = UIImageView().then {
        $0.image = UIImage(systemName: "sun.max.fill")
        $0.contentMode = .center
        $0.tintColor = .orange
    }
    let dateLabel = UILabel().then {
        $0.text = "날짜"
        $0.textAlignment = .left
    }
    let highTempLable = UILabel().then {
        $0.text = "0°C"
        $0.textColor = .systemRed
        $0.textAlignment = .right
    }
    let lowTempLable = UILabel().then {
        $0.text = "0°C"
        $0.textColor = .systemBlue
        $0.textAlignment = .right
    }
    let stack = UIStackView().then {
        $0.axis = .horizontal
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.distribution = .fillEqually
    }
    
    let tempStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
    }
    
    // MARK: - 생성자
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
    
    // MARK: - 오토레이아웃
    func setUpView() {
        addSubview(stack)
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(tempStack)
        tempStack.addArrangedSubview(highTempLable)
        tempStack.addArrangedSubview(lowTempLable)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
