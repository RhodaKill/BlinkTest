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
        guard conversations.isEmpty else { return } /// As we don't save yet, we don't want to "reload" and lose all our data when returning to the List view
        conversations = try dependencies.service.fetchConversations(from: "code_test_data")
    }
    
    func update(
        conversation: Conversation,
        with messageText: String
    ) async throws -> Conversation
    {
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            let currentDate = Date()
            conversations[index].lastUpdated = currentDate
            let message = Message(id: dependencies.messageIDGenerator(), text: messageText, lastUpdated: currentDate)
            conversations[index].messages.append(message)
            return conversations[index]
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
