//
//  ConversationsManager.swift
//  BlinkTest
//

import Foundation

actor ConversationsManager {
    private(set) var conversations: [Conversation] = []
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func fetchConversations() async throws {
        conversations = try dependencies.service.fetchConversations(from: "code_test_data")
    }
    
    func addMessage(
        _ messageText: String,
        toConversationID conversationID: String
    ) async throws {
        if let index = conversations.firstIndex(where: { $0.id == conversationID }) {
            let message = Message(id: dependencies.messageIDGenerator(), text: messageText, lastUpdated: Date())
            conversations[index].messages.append(message)
        } else {
            throw CustomError.conversationNotFound
        }
    }
}

extension ConversationsManager {
    struct Dependencies: Sendable {
        let messageIDGenerator: @Sendable () -> String
        let service: ConversationsServiceProtocol
        
        public static var `default`: Self {
            .init(
                messageIDGenerator: { UUID().uuidString },
                service: ConversationsService()
            )
        }
    }
}
