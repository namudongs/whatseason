//
//  NetworkHelper.swift
//  whatseason
//
//  Created by namdghyun on 1/20/24.
//

import Foundation

class NetworkHelper {
    static let shared = NetworkHelper()
    private let session = URLSession.shared

    func fetchData(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await session.data(from: url)
        return data
    }
}

struct WResponse: Decodable {
    let response: WBody
}

struct WBody: Decodable {
    let header: WHeader
    let body: WItems
}

struct WHeader: Decodable {
    let resultCode: String
    let resultMsg: String
}

struct WItems: Decodable {
    let items: WData
}

struct WData: Decodable {
    let item: [WItem]
}

struct WItem: Decodable {
    let baseDate: String
    let baseTime: String
    let category: String
    let fcstDate: String?
    let fcstTime: String?
    let fcstValue: String?
    let nx: Int
    let ny: Int
    let obsrValue: String?
}
