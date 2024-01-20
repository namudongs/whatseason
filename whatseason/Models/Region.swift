//
//  Region.swift
//  whatseason
//
//  Created by namdghyun on 1/21/24.
//

import Foundation

public let regionGroups = [
    "11B00000": ("서울, 인천, 경기도", "109"),
    "11D10000": ("강원도영서", "105"),
    "11D20000": ("강원도영동", "105"),
    "11C20000": ("대전, 세종, 충청남도", "133"),
    "11C10000": ("충청북도", "131"),
    "11F20000": ("광주, 전라남도", "156"),
    "11F10000": ("전라북도", "146"),
    "11H10000": ("대구, 경상북도", "143"),
    "11H20000": ("부산, 울산, 경상남도", "159"),
    "11G00000": ("제주도", "184")
]


struct Region: Codable {
    var key: String
    var value: String
}

func loadRegions() -> [String: String]? {
    guard let url = Bundle.main.url(forResource: "region", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        return nil
    }

    do {
        let regions = try JSONDecoder().decode([String: String].self, from: data)
        return regions
    } catch {
        print("Error loading or parsing region.json: \(error)")
        return nil
    }
}
