//
//  ConversationsListViewModel.swift
//  BlinkTest
//

import Foundation

@MainActor
protocol ConversationsListViewModelProtocol: ObservableObject {
    var state: ConversationsListViewModel.State { get }
    var manager: ConversationsManager { get }

    func fetchConversations() async
}

@MainActor
final class ConversationsListViewModel: ConversationsListViewModelProtocol {
    @Published private(set) var state: State = .loading
    
    private(set) var manager: ConversationsManager
    
    init(manager: ConversationsManager) {
        self.manager = manager
    }
    
    func fetchConversations() async {
        do {
            try await manager.fetchConversations()
            state = await .loaded(manager.conversations.sorted(by: { $0.lastUpdated < $1.lastUpdated } )) /// Oldest first
        } catch {
            state = .error(error)
        }
    }
}

extension ConversationsListViewModel {
    enum State {
        case loading
        case loaded([Conversation])
        case error(Error)
    }
}
