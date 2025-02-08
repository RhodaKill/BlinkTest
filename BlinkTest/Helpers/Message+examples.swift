//
//  Message+examples.swift
//  BlinkTest
//

import Foundation

extension Message {
    static func examples(count: Int) -> [Message] {
        var messages: [Message] = []
        for i in 0..<count {
            messages.append(.init(id: "id_\(i)", text: "This is message number \(i)", lastUpdated: Date()))
        }
        return messages
    }
}
