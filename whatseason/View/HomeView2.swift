//
//  HomeView2.swift
//  whatseason
//
//  Created by namdghyun on 1/18/24.
//

import UIKit

class HomeView2: UIView {
    // MARK: - 프로퍼티
    let mainLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        $0.text = "시간별 날씨"
    }

    // MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 메서드
    func setUpView() {
        self.backgroundColor = .white.withAlphaComponent(0.9)
        
        addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }
}