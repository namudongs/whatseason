//
//  WeatherView.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import UIKit
import WeatherKit
import SnapKit
import Then

class WeatherView: UIView {
    
    // MARK: - 프로퍼티
    var tableView = UITableView()
    
    let mainLabel = UILabel().then {
        $0.text = "날씨"
        $0.font = UIFont.systemFont(
            ofSize: 30
        )
        $0.textColor = .white
    }
    
    let temperatureLabel = UILabel().then {
        $0.text = "0.0"
        $0.font = UIFont.systemFont(
            ofSize: 30
        )
        $0.textColor = .white
    }
    
    let conditionLabel = UILabel().then {
        $0.text = "0.0"
        $0.font = UIFont.systemFont(
            ofSize: 30
        )
        $0.textColor = .white
    }
    
    let locationLabel = UILabel().then {
        $0.text = "위치"
        $0.font = UIFont.systemFont(
            ofSize: 30
        )
        $0.textColor = .white
    }
    
    let stack = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    // MARK: - 생성자
    override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        
        backgroundColor = .systemBlue
        setUpView()
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    // MARK: - 메서드
    /// 날씨와 도시명을 받아 WeatherView를 업데이트하는 메서드입니다.
    func configure(
        with: Weather,
        city: String
    ) {
        temperatureLabel.text = "\(with.currentWeather.temperature.value.rounded())°C"
        conditionLabel.text = "\(with.currentWeather.condition)"
        locationLabel.text = "\(city)"
        print(with.currentWeather.date.description)
    }
    
    // MARK: - 오토레이아웃
    func setUpView() {
        addSubview(
            stack
        )
        addSubview(
            tableView
        )
        
        stack.addArrangedSubview(
            mainLabel
        )
        stack.addArrangedSubview(
            temperatureLabel
        )
        stack.addArrangedSubview(
            conditionLabel
        )
        stack.addArrangedSubview(
            locationLabel
        )
        
        stack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(0)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(
                stack.snp.bottom
            ).offset(
                10
            )
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
