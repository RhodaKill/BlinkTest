//
//  ConversationsService.swift
//  BlinkTest
//

import Foundation

protocol ConversationsServiceProtocol: Sendable {
    func fetchConversations(from fileName: String) throws -> [Conversation]
}

final class ConversationsService: ConversationsServiceProtocol {
    func fetchConversations(from fileName: String) throws -> [Conversation] {
        guard let data = try openJSONObjectRepresentation(named: fileName) else { return [] }
        return try getResponse(from: data)
    }
    
    private func openJSONObjectRepresentation(named: String) throws -> Data? {
        do {
            guard let filePath = Bundle.main.path(forResource: named, ofType: "json")
            else { throw CustomError.jsonError }
            
            let fileUrl = URL(fileURLWithPath: filePath)
            return try Data(contentsOf: fileUrl)
        } catch {
            throw CustomError.jsonError
        }
    }
    
    private func getResponse(from jsonData: Data) throws -> [Conversation] {
        return try JSONDecoder().decode([Conversation].self, from: jsonData)
    }
}
