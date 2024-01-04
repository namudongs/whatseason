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
    
    // MARK: - 객체 정의
    let mainLabel: UILabel = UILabel().then {
        $0.text = "날씨"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    let temperatureLabel: UILabel = UILabel().then {
        $0.text = "0.0"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    let conditionLabel: UILabel = UILabel().then {
        $0.text = "0.0"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    let locationLabel: UILabel = UILabel().then {
        $0.text = "위치"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    let stack: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    // MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBlue
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with: Weather, city: String) {
        temperatureLabel.text = "\(with.currentWeather.temperature.value.rounded())°C"
        conditionLabel.text = "\(with.currentWeather.condition)"
        locationLabel.text = "\(city)"
    }
    
    
    // MARK: - 오토레이아웃
    func setUpView() {
        stack.addArrangedSubview(mainLabel)
        stack.addArrangedSubview(temperatureLabel)
        stack.addArrangedSubview(conditionLabel)
        stack.addArrangedSubview(locationLabel)
        
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
}
