//
//  ConversationsManager.swift
//  BlinkTest
//

import Foundation
import Testing
@testable import BlinkTest

final class ConversationsManagerTests {
    let service = MockConversationsService()
    let sut: ConversationsManager
    
    init() {
        sut = ConversationsManager(
            dependencies: .init(
                messageIDGenerator: { Constants.messageIDToGenerate },
                service: service
            )
        )
    }
    
    @Test("Fetch conversations calls service fetch conversations with correct filename")
    func fetchConversationsServiceCall() async throws {
        try await sut.fetchConversations()
        
        #expect(service.fetchConversationsCalledValues == ["code_test_data"])
    }
    
    @Test("Fetch conversations fetches conversations from the service and stores them in conversations")
    func fetchConversationsStoresConversations() async throws {
        let expectedConversations = Conversation.examples(count: 5)
        service.fetchConversationsReturnValue = expectedConversations
        
        await #expect(sut.conversations.isEmpty)
        
        try await sut.fetchConversations()
        
        await #expect(sut.conversations == expectedConversations)
    }
    
    @Test("Update conversation with Message updates the message and last updated date and stores the updated conversation")
    func updateConversationWithMessage() async throws {
        let converstionToUpdate = Conversation.example()
        service.fetchConversationsReturnValue = [converstionToUpdate]
        let expectedMessage = "Hello there!"
        
        try await sut.fetchConversations() /// Required to populate the conversations array
        let result = try await sut.update(conversation: converstionToUpdate, with: expectedMessage)
        
        #expect(result.messages.last?.text == expectedMessage)
        #expect(result.messages.last?.lastUpdated == result.messages.last?.lastUpdated)
        await #expect(sut.conversations.first == result)
    }
    
    @Test("Update conversation throws error if conversation is not found in the store")
    func updateConversationWithMessageError() async throws {
        let expectedError = CustomError.conversationNotFound
        
        await #expect(throws: expectedError, performing: {
            _ = try await sut.update(conversation: Conversation.example(), with: "I have a bad feeling about this...")
        })
    }
}

extension ConversationsManagerTests {
    struct Constants {
        static let messageIDToGenerate = "123"
    }
}
