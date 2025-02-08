//
//  ConversationViewModel.swift
//  BlinkTest
//

import Foundation

@MainActor
protocol ConversationViewModelProtocol: ObservableObject {
    var conversation: Conversation { get }
    var newMessage: String { get set }
    
    func sendMessage() async
}

@MainActor
final class ConversationViewModel: ConversationViewModelProtocol {
    @Published private(set) var conversation: Conversation
    @Published var newMessage: String = ""
    
    private let manager: ConversationsManager
    
    init(conversation: Conversation,
         manager: ConversationsManager
    ) {
        self.manager = manager
        self.conversation = conversation
    }
    
    func sendMessage() async {
        do {
            try await conversation = manager.update(conversation: conversation, with: newMessage)
            newMessage = ""
        } catch {
            print("Something went wrong") /// Would be better to display this to the User
        }
    }
}
