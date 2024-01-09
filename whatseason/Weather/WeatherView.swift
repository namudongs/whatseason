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
    let tableView = UITableView().then {
        $0.rowHeight = 50
    }
    
    let locationIcon = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.down")
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    let locationLabel = UILabel().then {
        $0.text = "--"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    let locationStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
    }
    
    let settingIcon = UIImageView().then {
        $0.image = UIImage(systemName: "slider.horizontal.3")
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    let headerStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalCentering
        $0.spacing = 5
    }
    
    let temperatureLabel = UILabel().then {
        $0.text = "--"
        $0.font = UIFont.systemFont(ofSize: 100, weight: .ultraLight, width: .standard)
    }
    
    let highlowTempView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    let highTemp = UILabel().then {
        $0.text = "4"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
        $0.textColor = .systemRed
    }
    
    let lowTemp = UILabel().then {
        $0.text = "-6"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
        $0.textColor = .systemBlue
    }
    
    let highlowTempStack = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 3
    }
    
    let tempLabelStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
    }
    
    let conditionIcon = LottieAnimationView(name: "partly-cloudy-day").then {
        $0.contentMode = .scaleAspectFill
        $0.loopMode = .loop
        $0.animationSpeed = 1.0
        $0.play()
    }
    
    let tempBodyStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalCentering
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
        
        self.backgroundColor = .white
        setUpView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 메서드
    /// 날씨와 도시명을 받아 WeatherView를 업데이트하는 메서드입니다.
    func configure(_ with: Weather, _ city: String, _ date: String) {
        dateLabel.text = "\(date)"
        temperatureLabel.text = "\(Int(with.currentWeather.temperature.value.rounded()))"
        conditionLabel.text = "\(translateWeatherCondition(with.currentWeather.condition))"
        locationLabel.text = "\(city)"
        print(date)
        
        // 온도 그라데이션 설정
        highlowTempView.setGradient(
            color1: UIColor.systemBlue,
            color2: UIColor.systemRed,
            loc: [0.0, 1.0],
            start: CGPoint(x: 0.0, y: 1.0),
            end: CGPoint(x: 0.0, y: 0.0)
        )
    }
    
    func translateWeatherCondition(_ condition: WeatherCondition) -> String {
        switch condition {
        case .blizzard:
            return "눈보라"
        case .blowingDust:
            return "먼지바람"
        case .blowingSnow:
            return "눈바람"
        case .breezy:
            return "약한 바람"
        case .clear:
            return "맑음"
        case .cloudy:
            return "흐림"
        case .drizzle:
            return "이슬비"
        case .flurries:
            return "소나기"
        case .foggy:
            return "안개"
        case .freezingDrizzle:
            return "얼어붙는 이슬비"
        case .freezingRain:
            return "얼어붙는 비"
        case .frigid:
            return "추위"
        case .hail:
            return "우박"
        case .haze:
            return "실안개"
        case .heavyRain:
            return "폭우"
        case .heavySnow:
            return "폭설"
        case .hot:
            return "더위"
        case .hurricane:
            return "허리케인"
        case .isolatedThunderstorms:
            return "간헐적 뇌우"
        case .mostlyClear:
            return "대체로 맑음"
        case .mostlyCloudy:
            return "대체로 흐림"
        case .partlyCloudy:
            return "구름 조금"
        case .rain:
            return "비"
        case .scatteredThunderstorms:
            return "산발적 뇌우"
        case .sleet:
            return "진눈깨비"
        case .smoky:
            return "연기"
        case .snow:
            return "눈"
        case .strongStorms:
            return "강한 폭풍"
        case .sunFlurries:
            return "해"
        case .sunShowers:
            return "여우비"
        case .thunderstorms:
            return "뇌우"
        case .tropicalStorm:
            return "열대폭풍"
        case .windy:
            return "바람"
        case .wintryMix:
            return "차가운 바람"
        default:
            return "알 수 없음"
        }
    }
            
    // MARK: - 오토레이아웃
    func setUpView() {
        addSubview(headerStack)
        addSubview(tempBodyStack)
        
        locationStack.addArrangedSubview(locationIcon)
        locationStack.addArrangedSubview(locationLabel)
        
        headerStack.addArrangedSubview(locationStack)
        headerStack.addArrangedSubview(settingIcon)
        
        highlowTempStack.addArrangedSubview(highTemp)
        highlowTempStack.addArrangedSubview(highlowTempView)
        highlowTempStack.addArrangedSubview(lowTemp)
        
        tempLabelStack.addArrangedSubview(temperatureLabel)
        tempLabelStack.addArrangedSubview(highlowTempStack)
        
        tempBodyStack.addArrangedSubview(tempLabelStack)
        tempBodyStack.addArrangedSubview(conditionIcon)
        
        // ------------ 헤더 ------------
        headerStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
        }
        
        locationIcon.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        settingIcon.snp.makeConstraints { make in
            make.width.height.equalTo(25)
        }
        // ------------ 헤더 끝 ------------
        
        // ------------ 온도/날씨 바디 ------------
        tempBodyStack.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(tempLabelStack.snp.bottom)
        }
        
        highlowTempView.snp.makeConstraints { make in
            make.width.equalTo(1)
        }
        
        highlowTempStack.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.top).offset(25)
            make.bottom.equalTo(temperatureLabel.snp.bottom).offset(-25)
            make.leading.equalTo(temperatureLabel.snp.trailing).offset(10)
        }
        
        conditionIcon.snp.makeConstraints { make in
            make.width.height.equalTo(125)
        }
        // ------------ 온도/날씨 바디 끝 ------------
        
    }
}
