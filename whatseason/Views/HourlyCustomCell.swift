//
//  HourlyCustomCell.swift
//  whatseason
//
//  Created by namdghyun on 1/22/24.
//

import UIKit
import Lottie

class HourlyCustomCell: UICollectionViewCell {
    static let identifier = "HourlyCustomCell"
    
    let icon = LottieAnimationView(name: "clear").then {
        $0.contentMode = .scaleAspectFill
        $0.loopMode = .loop
        $0.animationSpeed = 1.0
        $0.play()
    }
    
    let temp = UILabel().then {
        $0.text = ""
    }
    
    let rainType = UILabel().then {
        $0.text = ""
    }
    
    let rain = UILabel().then {
        $0.text = ""
    }
    
    let stack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ w: HourlyW) {
        temp.text = "\(w.temperature ?? 0.0)°"
        rainType.text = rainTypeDescription(from: w.rainType)
        rain.text = w.precipitation ?? "강수없음"
    }
    
    private func rainTypeDescription(from type: Int?) -> String {
        switch type {
        case 1: return "비"
        case 2: return "비/눈"
        case 3: return "눈"
        case 4: return "소나기"
        default: return "없음"
        }
    }
    
    func setUpView() {
        backgroundColor = .clear
        
        addSubview(stack)
//        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(temp)
        stack.addArrangedSubview(rainType)
        stack.addArrangedSubview(rain)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
