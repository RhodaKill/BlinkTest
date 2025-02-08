//
//  ConversationView.swift
//  BlinkTest
//

import SwiftUI

struct ConversationView<T: ConversationViewModelProtocol>: View {
    @ObservedObject var viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.conversation.sortedMessages, id: \.id) { message in
                    messageCell(message: message)
                }
            }
         
            HStack {
                TextField("Enter message", text: $viewModel.newMessage)
                Spacer()
                Button(action: {
                    Task {
                        await viewModel.sendMessage()
                    }
                }, label: {
                    Text("Send")
                })
                .frame(width: 40)
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
    }
    
    @MainActor
    private func messageCell(message: Message) -> some View {
        VStack {
            HStack {
                Text(message.text)
                Spacer()
            }
            
            HStack {
                Text(DateHelper.dateString(from: message.lastUpdated))
                Spacer()
            }
        }
    }
}

#Preview {
    ConversationView(viewModel: ConversationViewModel(conversation: .example(messages: Message.examples(count: 10)), manager: ConversationsManager(dependencies: .default)))
}
