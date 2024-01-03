//
//  ForecastCell.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import UIKit
import WeatherKit
import SnapKit

class ForecastCell: UICollectionViewCell {
    
    // MARK: - 객체
    private let stack = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
    }
    
    private let dateLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
    }

    private let temperatureLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    private let precipitationProbabilityLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    

    // MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(stack)
        addSubview(dateLabel)
        addSubview(temperatureLabel)
        addSubview(precipitationProbabilityLabel)
        
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(temperatureLabel)
        stack.addArrangedSubview(precipitationProbabilityLabel)

        stack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - 뷰 업데이트
    func configure(with data: HourWeather) {
        dateLabel.text = "\(data.date)"
        temperatureLabel.text = "\(data.temperature.value)°"
        precipitationProbabilityLabel.text = "강수 확률: \(data.precipitationChance * 100)%"
    }
}
