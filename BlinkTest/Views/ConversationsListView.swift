//
//  ConversationsListView.swift
//  BlinkTest
//

import SwiftUI

struct ConversationsListView<T: ConversationsListViewModelProtocol>: View {
    @ObservedObject var viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case let .loaded(conversations):
                    List {
                        ForEach(conversations, id: \.id) { conversation in
                            conversationCell(conversation: conversation)
                        }
                    }
                case .error:
                    Text("Something went wrong")
                }
            }
            .task() {
                await viewModel.fetchConversations()
            }
        }
        
    }
    
    @MainActor
    private func conversationCell(conversation: Conversation) -> some View {
        NavigationLink(
            destination: ConversationView(viewModel: ConversationViewModel(conversation: conversation, manager: viewModel.manager))
        ) {
            VStack {
                HStack {
                    Text(conversation.name)
                        .bold()
                    Spacer()
                }
                
                if let lastMessageText = conversation.messages.last?.text {
                    HStack {
                        Text(lastMessageText)
                        Spacer()
                    }
                }
                
                HStack {
                    Text(DateHelper.dateString(from: conversation.lastUpdated))
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ConversationsListView(viewModel: ConversationsListViewModel(manager: ConversationsManager(dependencies: .default)))
}
