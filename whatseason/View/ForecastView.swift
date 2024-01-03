//
//  ForecastView.swift
//  whatseason
//
//  Created by namdghyun on 1/3/24.
//

import UIKit
import WeatherKit
import SnapKit
import Then

class ForecastView: UIView {
    private var hourlyData: [HourWeather] = []

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.itemSize = CGSize(width: 200, height: 100) // 셀 크기는 조절 가능
        }
    ).then {
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        $0.showsHorizontalScrollIndicator = false
        $0.register(ForecastCell.self, forCellWithReuseIdentifier: "ForecastCell")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }

    func updateData(with data: [HourWeather]) {
        self.hourlyData = data
        collectionView.reloadData()
    }
}

extension ForecastView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as? ForecastCell else {
            return UICollectionViewCell()
        }
        let data = hourlyData[indexPath.row]
        cell.configure(with: data)
        return cell
    }
}
