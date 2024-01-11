//
//  HomeView.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import UIKit
import WeatherKit
import SnapKit
import Then
import Lottie

class HomeView: UIView {
    
    // MARK: - 프로퍼티
    let homeMainView = HomeMainView()
    
    let testView1 = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    let testView2 = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    let testView3 = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    let testView4 = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    let testViewStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 15
    }
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 메서드
    /// 날씨와 도시명을 받아 WeatherView를 업데이트하는 메서드입니다.
    func configure(_ with: Weather, _ city: String, _ date: String) {
        let currentWeather = with.currentWeather
        let condition = currentWeather.condition.translateWeatherCondition()
        let temp = Int(round(currentWeather.temperature.value))
        let humidity = Int(round(currentWeather.humidity * 100))
        print("\(date) \(city)의 날씨는 \(condition)")
        
        homeMainView.dateLabel.text = "\(date) 기준"
        homeMainView.cityLabel.text = "\(city)"
        homeMainView.conditionLabel.text = "\(condition)"
        homeMainView.temperatureLabel.text = "\(temp)°"
        homeMainView.humidityLabel.text = "\(humidity)%"
    }
    
    /// Lottie 배경을 추가하는 메서드입니다.
    func addBackgroundLottie(_ lottieName: String) {
        let lottieBackground = LottieAnimationView(name: lottieName).then {
            $0.contentMode = .scaleAspectFill
            $0.loopMode = .loop
            $0.animationSpeed = 1.0
            $0.play()
        }
        self.backgroundColor = .black
        lottieBackground.alpha = 0.7
        
        addSubview(lottieBackground)
        lottieBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - 오토레이아웃
    func setUpView() {
        addSubview(scrollView)
        
        scrollView.addSubview(testViewStack)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
            
        }
        
        testViewStack.addArrangedSubview(homeMainView)
        testViewStack.addArrangedSubview(testView1)
        testViewStack.addArrangedSubview(testView2)
        testViewStack.addArrangedSubview(testView3)
        testViewStack.addArrangedSubview(testView4)
        
        testViewStack.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.leading.equalTo(scrollView.contentLayoutGuide.snp.leading).offset(15)
            make.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing).offset(15)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width).offset(-30)
        }
        
        homeMainView.snp.makeConstraints { make in
            make.height.equalTo(500)
        }
        testView1.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        testView2.snp.makeConstraints { make in
            make.height.equalTo(400)
        }
        testView3.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        testView4.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }
    
}
