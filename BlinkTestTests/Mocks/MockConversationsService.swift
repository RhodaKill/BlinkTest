//
//  MockConversationsService.swift
//  BlinkTest
//

import Foundation
@testable import BlinkTest

final class MockConversationsService: @unchecked Sendable {
    var fetchConversationsCalledValues: [String] = []
    var fetchConversationsCalledCount: Int { fetchConversationsCalledValues.count }
    
    var fetchConversationsReturnValue: [Conversation] = []
    
    var lock = NSLock()
}

extension MockConversationsService: ConversationsServiceProtocol {
    func fetchConversations(from fileName: String) throws -> [Conversation] {
        lock.withLock {
            fetchConversationsCalledValues.append(fileName)
            return fetchConversationsReturnValue
        }
    }
}
