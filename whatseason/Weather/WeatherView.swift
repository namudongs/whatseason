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
import Lottie

class WeatherView: UIView {
    
    // MARK: - 프로퍼티
    let testView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let testView1 = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.7)
    }
    
    let testView2 = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.7)
    }
    
    let testView3 = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.7)
    }
    
    let testView4 = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.7)
    }
    
    let testViewStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 15
    }
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    let locationLabel = UILabel().then {
        $0.text = "--"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    let temperatureLabel = UILabel().then {
        $0.text = "--"
        $0.font = UIFont.systemFont(ofSize: 100, weight: .ultraLight, width: .standard)
    }
    
    let conditionLabel = UILabel().then {
        $0.text = "--"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .thin)
    }
    
    let dateLabel = UILabel().then {
        $0.text = "--"
        $0.font = UIFont.systemFont(ofSize: 20)
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
        print("\(date) \(city)의 날씨는 \(condition)입니다.")
        
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
        lottieBackground.alpha = 0.9
        
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
        
        testViewStack.addArrangedSubview(testView)
        testViewStack.addArrangedSubview(testView1)
        testViewStack.addArrangedSubview(testView2)
        testViewStack.addArrangedSubview(testView3)
        testViewStack.addArrangedSubview(testView4)
        
        testViewStack.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            make.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        testView.snp.makeConstraints { make in
            make.height.equalTo(400)
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
