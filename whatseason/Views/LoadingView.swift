//
//  LoadingView.swift
//  whatseason
//
//  Created by namdghyun on 1/20/24.
//

import UIKit

class LoadingView: UIView {
    
    private let activityIndicator = UIActivityIndicatorView().then {
        $0.style = .large
        $0.color = .white
    }
    private let loadingLabel = UILabel().then {
        $0.text = "데이터를 불러오고 있습니다..."
        $0.textColor = .white
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor(white: 0, alpha: 0.8)
        
        addSubview(activityIndicator)
        addSubview(loadingLabel)
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        loadingLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(activityIndicator.snp.bottom).offset(16)
        }
        
        activityIndicator.startAnimating()
    }
}
