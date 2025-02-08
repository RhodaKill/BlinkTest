//
//  Conversation.swift
//  BlinkTest
//

import Foundation

struct Conversation {
    let id: String
    let name: String
    let lastUpdated: Date
    var messages: [Message]
}

extension Conversation: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case lastUpdated = "last_updated"
        case messages
    }
    
    init(from decoder: Decoder) throws {
        let lastUpdatedString = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .lastUpdated)
        guard let lastUpdatedDate = DateHelper.date(from: lastUpdatedString) else { throw CustomError.parsingError }
        
        self.id = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .id)
        self.name = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .name)
        self.messages = try decoder.container(keyedBy: CodingKeys.self).decode([Message].self, forKey: .messages)
        self.lastUpdated = lastUpdatedDate
    }
}

extension Conversation: Equatable {}
