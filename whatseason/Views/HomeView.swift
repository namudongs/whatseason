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
    let homeFirstView = HomeFirstView()
    
    let homeSecondView = HomeSecondView()
    
    let homeThirdView = HomeThirdView()
    
    let homeFourthView = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.9)
    }
    
    let homeFifthView = UIView().then {
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
    /// 애플날씨와 도시명을 받아 WeatherView를 업데이트하는 메서드입니다.
    func configure(_ w: AnyW, _ address: String) {
        // HomeFirstView에 데이터 전달
        homeFirstView.configure(w, address)
        
        // HomeSecondView에 데이터 전달
        homeSecondView.configure(w)
        
        // HomeThirdView에 데이터 전달
        
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
        
        homeViewStack.addArrangedSubview(homeFirstView)
        homeViewStack.addArrangedSubview(homeSecondView)
        homeViewStack.addArrangedSubview(homeThirdView)
        homeViewStack.addArrangedSubview(homeFourthView)
        homeViewStack.addArrangedSubview(homeFifthView)
        
        homeViewStack.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            make.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        homeFirstView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height * 0.35)
        }
        homeSecondView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
        homeThirdView.snp.makeConstraints { make in
            make.height.equalTo(400)
        }
        homeFourthView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        homeFifthView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }
    
}
