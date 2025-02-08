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
    
    @Test("Add message adds a new message to the correct conversation")
    func addMessage() async throws {
        let converstionToUpdate = Conversation.example
        service.fetchConversationsReturnValue = [converstionToUpdate]
        let expectedMessage = "Hello there!"
        
        try await sut.fetchConversations() /// Required to populate the conversations array
        try await sut.addMessage(expectedMessage, toConversationID: converstionToUpdate.id)
        
        await #expect(sut.conversations.first?.messages.last?.text == expectedMessage)
    }
    
    @Test("Add message throws error if no conversation with the provided ID is found")
    func addMessageError() async throws {
        let expectedError = CustomError.conversationNotFound
        
        await #expect(throws: expectedError, performing: {
            try await sut.addMessage("I have a bad feeling about this...", toConversationID: "ID")
        })
    }
}

extension ConversationsManagerTests {
    struct Constants {
        static let messageIDToGenerate = "123"
    }
}
