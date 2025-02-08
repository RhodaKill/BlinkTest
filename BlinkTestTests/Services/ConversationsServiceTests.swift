//
//  MockConversationsService.swift
//  BlinkTest
//

import Foundation
import Testing
@testable import BlinkTest

final class ConversationsServiceTests {
    let sut = ConversationsService()
    
    @Test("Fetch conversations when decoding goes wrong throws jsonError")
    func fetchConversationsNoJSON() throws {
        let expectedError = CustomError.jsonError
        
        #expect(throws: expectedError, performing: {
           _ = try sut.fetchConversations(from: "MISSING")
        })
    }
    
    @Test("Fetch conversations when provided with correct JSON returns correct conversations")
    func fetchConversationsReturnsConversations() throws {
        let result = try sut.fetchConversations(from: "code_test_data")
        
        #expect(result.count == 5)
        
        let expectedFirstResult = Conversation(
            id: "5f58bcd7a88fab5f34df94d6",
            name: "eiusmod nostrud sunt",
            lastUpdated: DateHelper.date(from: "2020-05-04T03:37:18")!,
            messages: [
                .init(id: "5f58bcd7352396fffbae8b6e",
                      text: "Lorem labore ea et",
                      lastUpdated: DateHelper.date(from: "2020-02-16T04:35:16")!
                     ),
                .init(id: "5f58bcd7d95151eaa14ab8aa",
                      text: "ex excepteur deserunt laboris",
                      lastUpdated: DateHelper.date(from: "2020-08-18T11:16:45")!
                     ),
                .init(id: "5f58bcd7f7745918c2252086",
                      text: "dolore sunt reprehenderit cupidatat",
                      lastUpdated: DateHelper.date(from: "2020-03-23T10:06:33")!
                     )
            ]
        )
        #expect(result.first == expectedFirstResult)
    }
}
