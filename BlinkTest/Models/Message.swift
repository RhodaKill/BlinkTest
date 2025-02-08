//
//  Message.swift
//  BlinkTest
//

import Foundation

struct Message {
    let id: String
    let text: String
    let lastUpdated: Date
}

extension Message: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case lastUpdated = "last_updated"
    }
    
    init(from decoder: Decoder) throws {
        let lastUpdatedString = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .lastUpdated)
        guard let lastUpdatedDate = DateHelper.date(from: lastUpdatedString) else { throw CustomError.parsingError }
        
        self.id = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .id)
        self.text = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .text)
        self.lastUpdated = lastUpdatedDate
    }
}

extension Message: Equatable {}
