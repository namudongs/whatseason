//
//  WeatherView.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import UIKit
import SnapKit
import Then

class WeatherView: UIView {
    
    // MARK: - 객체 정의
    let mainLabel: UILabel = UILabel().then {
        $0.text = "날씨"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    let weatherImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "sun.max.fill")
        $0.tintColor = .white
    }
    
    let temperatureLabel: UILabel = UILabel().then {
        $0.text = "0.0"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    let humidityLabel: UILabel = UILabel().then {
        $0.text = "0.0"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    let locationLabel: UILabel = UILabel().then {
        $0.text = "위치"
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    // MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBlue
        
        setUpMainLabel()
        setUpWeatherImageView()
        setUpTemperatureLabel()
        setUpHumidityLabel()
        setUpLocationLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 오토레이아웃
    func setUpMainLabel() {
        addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setUpWeatherImageView() {
        addSubview(weatherImageView)
        
        weatherImageView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setUpTemperatureLabel() {
        addSubview(temperatureLabel)
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherImageView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setUpHumidityLabel() {
        addSubview(humidityLabel)
        
        humidityLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setUpLocationLabel() {
        addSubview(locationLabel)
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(humidityLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    
}
