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
    let tableView = UITableView().then {
        $0.rowHeight = 50
    }
    
    let todayView = UIView().then {
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }
    
    let mainLabel = UILabel().then {
        $0.text = "날씨"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    let temperatureLabel = UILabel().then {
        $0.text = "0.0"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    let conditionLabel = UILabel().then {
        $0.text = "0.0"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    let locationLabel = UILabel().then {
        $0.text = "위치"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    let stack = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
    }
    
    // MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 메서드
    /// 날씨와 도시명을 받아 WeatherView를 업데이트하는 메서드입니다.
    func configure(with: Weather, city: String) {
        temperatureLabel.text = "\(Int(with.currentWeather.temperature.value.rounded())) °C"
        conditionLabel.text = "\(translateWeatherCondition(with.currentWeather.condition))"
        locationLabel.text = "\(city)"
        print(with.currentWeather.date.description)
        
        todayView.setGradient(
            color1: UIColor(red: 0.63, green: 0.77, blue: 0.99, alpha: 1.0),
            color2: UIColor(red: 0.76, green: 0.91, blue: 0.98, alpha: 1.0),
            loc: [0.0, 1.0],
            start: CGPoint(x: 0.86, y: 0.0),
            end: CGPoint(x: 0.14, y: 1.0)
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
        addSubview(todayView)
        todayView.addSubview(stack)
        
        stack.addArrangedSubview(mainLabel)
        stack.addArrangedSubview(locationLabel)
        stack.addArrangedSubview(temperatureLabel)
        stack.addArrangedSubview(conditionLabel)
        
        
        todayView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        stack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
