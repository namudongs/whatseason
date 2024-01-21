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
    let baseDate: String?
    let baseTime: String?
    let category: String?
    let fcstDate: String?
    let fcstTime: String?
    let fcstValue: String?
    let obsrValue: String?
    let rnSt3Am: Int?
    let rnSt3Pm: Int?
    let rnSt4Am: Int?
    let rnSt4Pm: Int?
    let rnSt5Am: Int?
    let rnSt5Pm: Int?
    let rnSt6Am: Int?
    let rnSt6Pm: Int?
    let rnSt7Am: Int?
    let rnSt7Pm: Int?
    let rnSt8: Int?
    let rnSt9: Int?
    let rnSt10: Int?
    let wf3Am: String?
    let wf3Pm: String?
    let wf4Am: String?
    let wf4Pm: String?
    let wf5Am: String?
    let wf5Pm: String?
    let wf6Am: String?
    let wf6Pm: String?
    let wf7Am: String?
    let wf7Pm: String?
    let wf8: String?
    let wf9: String?
    let wf10: String?
    let taMin3: Int?
    let taMax3: Int?
    let taMin4: Int?
    let taMax4: Int?
    let taMin5: Int?
    let taMax5: Int?
    let taMin6: Int?
    let taMax6: Int?
    let taMin7: Int?
    let taMax7: Int?
    let taMin8: Int?
    let taMax8: Int?
    let taMin9: Int?
    let taMax9: Int?
    let taMin10: Int?
    let taMax10: Int?
}

enum ParserError: Error {
    case invalidBaseDate
}
