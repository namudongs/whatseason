//
//  HomeMainView.swift
//  whatseason
//
//  Created by namdghyun on 1/12/24.
//

import UIKit
import Lottie

class HomeFirstView: UIView {
    // MARK: - 프로퍼티
    let dateLabel = UILabel().then {
        $0.text = "--"
        $0.textAlignment = .natural
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .white
    }
    
    let cityLabel = UILabel().then {
        $0.text = "--"
        $0.textAlignment = .natural
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        $0.textColor = .white
    }
    
    let conditionLabel = UILabel().then {
        $0.text = "--"
        $0.textAlignment = .natural
        $0.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        $0.textColor = .white
    }
    
    let temperatureLabel = UILabel().then {
        $0.text = "--"
        $0.textAlignment = .natural
        $0.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        $0.textColor = .white
    }
    
    let airLabel = UILabel().then {
        $0.text = "--"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        $0.textColor = .white
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        
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
    func configure(_ w: AnyW, _ address: String) {
        let apple = w.apple!.currentWeather
        let kma = w.currentW!
        
        let temp = Int(kma.temperature)
        let date = Date().toFormattedKoreanString()
        let condition = apple.condition.translateWeatherCondition()
        let conditionIcon = apple.condition.conditionToDayIconName()
        
        temperatureLabel.text = "\(temp)°"
        dateLabel.text = "\(date) 기준"
        cityLabel.text = "\(address)"
        conditionLabel.text = "\(condition)"
        
        // Condition에 따라 Icon 변경
        addWeatherLottie("\(conditionIcon)")
        
        // 미세먼지에 따라 변경
        airLabel.text = "보통"
        airLabel.backgroundColor = .systemGreen.withAlphaComponent(0.7)
    }
    
    func addWeatherLottie(_ lottieName: String) {
        let lottieIcon = LottieAnimationView(name: lottieName).then {
            $0.contentMode = .scaleAspectFill
            $0.loopMode = .loop
            $0.animationSpeed = 2
            $0.play()
        }
        
        addSubview(lottieIcon)
        lottieIcon.snp.makeConstraints { make in
            make.bottom.equalTo(cityLabel.snp.top)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    func setUpView() {
        self.backgroundColor = .clear
        
        addSubview(dateLabel)
        addSubview(cityLabel)
        addSubview(conditionLabel)
//        addSubview(temperatureLabel)
//        addSubview(airLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints { make in
            make.bottom.equalTo(conditionLabel.snp.top)
            make.centerX.equalToSuperview()
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(55)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
//        temperatureLabel.snp.makeConstraints { make in
//            make.bottom.equalToSuperview().offset(-10)
//            make.leading.equalToSuperview().offset(20)
//        }
        
//        airLabel.snp.makeConstraints { make in
//            make.top.equalTo(temperatureLabel.snp.top)
//            make.bottom.equalTo(temperatureLabel.snp.bottom)
//            make.trailing.equalToSuperview().offset(-20)
//            make.width.equalTo(80)
//        }
        
    }
}
