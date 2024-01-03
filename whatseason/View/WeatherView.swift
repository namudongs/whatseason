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
    
    // MARK: - 객체
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
    
    let hourlyForecastView: ForecastView = ForecastView().then {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
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
        setUpHourlyForecastView()
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
    
    func setUpHourlyForecastView() {
            addSubview(hourlyForecastView)

            hourlyForecastView.snp.makeConstraints {
                $0.top.equalTo(locationLabel.snp.bottom).offset(20)
                $0.left.right.equalToSuperview().inset(20)
                $0.height.equalTo(100) // 높이는 조정 가능
            }
        }
    
}
