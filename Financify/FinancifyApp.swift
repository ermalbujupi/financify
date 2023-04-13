//
//  FinancifyApp.swift
//  Financify
//
//  Created by Ermal Bujupaj on 10.04.23.
//

import SwiftUI
import Firebase

@main
struct FinancifyApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
