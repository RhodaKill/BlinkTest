//
//  Conversation+example.swift
//  BlinkTest
//

import Foundation

extension Conversation {
    static func example(
        messages: [Message] = [.init(id: "id_0", text: "text_0", lastUpdated: Date())]
    ) -> Conversation {
        .init(id: "id_0", name: "name_0", lastUpdated: Date(), messages: messages)
    }
    
    static func examples(count: Int) -> [Conversation] {
        var conversations: [Conversation] = []
        for i in 0..<count {
            conversations.append(Conversation(id: "id_\(i)", name: "name_\(i)", lastUpdated: Date(), messages: [.init(id: "id_\(i)", text: "text_\(i)", lastUpdated: Date())]))
        }
        return conversations
    }
}
