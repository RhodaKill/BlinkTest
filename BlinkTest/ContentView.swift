//
//  ContentView.swift
//  BlinkTest
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ConversationsListView(viewModel: ConversationsListViewModel(manager: ConversationsManager(dependencies: .default)))
    }
}

#Preview {
    ContentView()
}
