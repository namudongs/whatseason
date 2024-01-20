//
//  HomeView1.swift
//  whatseason
//
//  Created by namdghyun on 1/15/24.
//

import UIKit

class HomeSecondView: UIView {
    // MARK: - 프로퍼티
    // 메인 레이블
    let mainLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        $0.text = "현재 날씨"
    }
    
    // 메인 스택
    let mainStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 30
        $0.distribution = .equalSpacing
    }

    // 온도 스택
    let tempStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    let tempMainLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.text = "온도"
    }
    
    let tempValueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .black
        $0.text = "--°"
    }
    
    // 체감온도 스택
    let apperentTempStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    let apperentTempMainLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.text = "체감온도"
    }
    
    let apperentTempValueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .black
        $0.text = "--°"
    }
    
    // 습도 스택
    let humidityStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    let humidityMainLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.text = "습도"
    }
    
    let humidityValueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .black
        $0.text = "--%"
    }
    
    // 바람 스택
    let windStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    let windMainLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.text = "바람"
    }
    
    let windValueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .black
        $0.text = "--풍 -m/s"
    }
    
    // MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 메서드
    func configure(_ w: AnyW) {
//        let apple = weather.apple!.currentWeather
        let kma = w.currentW!
        
        let temp = Int(round(kma.temperature))
        let humidity = kma.humidity
        let windSpeed = kma.windSpeed
        let windDirection = kma.translateWindDirection()
        let kmaApperent = Int(round(kma.calculateFeelsLikeTemperature()))
        
        tempValueLabel.text = "\(temp)°"
        apperentTempValueLabel.text = "\(kmaApperent)°"
        humidityValueLabel.text = "\(humidity)%"
        windValueLabel.text = "\(windDirection)풍 \(windSpeed)m/s"
    }
    
    func setUpView() {
        self.backgroundColor = .white.withAlphaComponent(0.9)
        
        addSubview(mainLabel)
        addSubview(mainStack)
        mainStack.addArrangedSubview(tempStack)
        mainStack.addArrangedSubview(apperentTempStack)
        mainStack.addArrangedSubview(humidityStack)
        mainStack.addArrangedSubview(windStack)
        
        tempStack.addArrangedSubview(tempMainLabel)
        tempStack.addArrangedSubview(tempValueLabel)
        
        apperentTempStack.addArrangedSubview(apperentTempMainLabel)
        apperentTempStack.addArrangedSubview(apperentTempValueLabel)
        
        humidityStack.addArrangedSubview(humidityMainLabel)
        humidityStack.addArrangedSubview(humidityValueLabel)
        
        windStack.addArrangedSubview(windMainLabel)
        windStack.addArrangedSubview(windValueLabel)
        
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        mainStack.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
}
