//
//  HomeMainView.swift
//  whatseason
//
//  Created by namdghyun on 1/12/24.
//

import UIKit
import SnapKit
import Then
import Lottie

class HomeMainView: UIView {
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
        $0.font = UIFont.systemFont(ofSize: 35, weight: .bold)
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
        $0.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        $0.textColor = .white
    }
    
    let humidityLabel = UILabel().then {
        $0.text = "--"
        $0.textAlignment = .natural
        $0.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        $0.textColor = .white
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
    func addWeatherLottie(_ lottieName: String) {
        let lottieIcon = LottieAnimationView(name: lottieName).then {
            $0.contentMode = .scaleAspectFill
            $0.loopMode = .loop
            $0.animationSpeed = 1.0
            $0.play()
        }
        
        addSubview(lottieIcon)
        lottieIcon.snp.makeConstraints { make in
            make.top.equalTo(conditionLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    func setUpView() {
        self.backgroundColor = .clear
        
        addSubview(dateLabel)
        addSubview(cityLabel)
        addSubview(conditionLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints { make in
            make.bottom.equalTo(conditionLabel.snp.top)
            make.centerX.equalToSuperview()
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        
    }
}
