//
//  BlinkTestApp.swift
//  BlinkTest
//

import SwiftUI

@main
struct BlinkTestApp: App {
    var body: some Scene {
        WindowGroup {
            if isProduction {
                ContentView()
            }
        }
    }
    
    private var isProduction: Bool {
        NSClassFromString("XCTestCase") == nil
    }
}
