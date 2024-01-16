//
//  HomeView1.swift
//  whatseason
//
//  Created by namdghyun on 1/15/24.
//

import UIKit
import WeatherKit
import Lottie

class HomeView1: UIView {
    
    // MARK: - 프로퍼티
    
    // MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 메서드
    func configure(weather: CurrentWeather) {
        
    }
    
    func setUpView() {
        self.backgroundColor = .white.withAlphaComponent(0.9)
    }
}
