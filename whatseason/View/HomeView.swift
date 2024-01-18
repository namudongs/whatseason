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
    
    let homeView1 = HomeView1()
    
    let homeView2 = HomeView2()
    
    let testView3 = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.9)
    }
    
    let testView4 = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.9)
    }
    
    let homeViewStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
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
        print(currentWeather.wind.direction.value)
        print("\(date) \(city)의 날씨는 \(condition) 온도는 \(temp) 습도는 \(humidity)")
        
        homeMainView.dateLabel.text = "\(date) 기준"
        homeMainView.cityLabel.text = "\(city)의 날씨는 ···"
        homeMainView.conditionLabel.text = "\(condition)"
        homeMainView.temperatureLabel.text = "\(temp)°"
        
        // Condition에 따라 Icon 변경
        homeMainView.addWeatherLottie("\(currentWeather.condition.conditionToDayIconName())")
        
        // 미세먼지에 따라 변경
        homeMainView.airLabel.text = "보통"
        homeMainView.airLabel.backgroundColor = .systemGreen.withAlphaComponent(0.7)
        
        // HomeView1에 데이터 전달
        homeView1.configure(weather: with.currentWeather)
    }
    
    /// Lottie 배경을 추가하는 메서드입니다.
    func addBackgroundLottie(_ lottieName: String, _ lottieName2: String = "blob") {
        let lottieBackground = LottieAnimationView(name: lottieName).then {
            $0.contentMode = .scaleAspectFill
            $0.loopMode = .loop
            $0.animationSpeed = 1.0
            $0.play()
        }
        
        let lottieBackground2 = LottieAnimationView(name: lottieName2).then {
            $0.contentMode = .scaleAspectFill
            $0.loopMode = .loop
            $0.animationSpeed = 1.0
            $0.play()
        }
        
        self.backgroundColor = .black
        lottieBackground.alpha = 0.7
        lottieBackground2.alpha = 0.7
        
        addSubview(lottieBackground)
        addSubview(lottieBackground2)
        lottieBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lottieBackground2.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 1.5)
        }
    }
    
    // MARK: - 오토레이아웃
    func setUpView() {
        addSubview(scrollView)
        
        scrollView.addSubview(homeViewStack)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
            
        }
        
        homeViewStack.addArrangedSubview(homeMainView)
        homeViewStack.addArrangedSubview(homeView1)
        homeViewStack.addArrangedSubview(homeView2)
        homeViewStack.addArrangedSubview(testView3)
        homeViewStack.addArrangedSubview(testView4)
        
        homeViewStack.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            make.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        homeMainView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height * 0.5)
        }
        homeView1.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
        homeView2.snp.makeConstraints { make in
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
