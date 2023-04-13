//
//  ContentView.swift
//  Financify
//
//  Created by Ermal Bujupaj on 10.04.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Transaction")
                .tabItem {
                    HStack {
                        Image(systemName: "list.bullet")
                        Text("Transaction")
                    }
                    
                }
            Text("Budgets")
                .tabItem {
                    HStack {
                        Image(systemName: "creditcard")
                        Text("Budgets")
                    }
                }
            Text("Saving Goals")
                .tabItem {
                    HStack {
                        Image(systemName: "banknote")
                        Text("Saving Goals")
                    }
                }
            Text("Reports")
                .tabItem {
                    HStack {
                        Image(systemName: "doc")
                        Text("Reports")
                    }
                }
            Text("Settings")
                .tabItem {
                    HStack {
                        Image(systemName: "wrench.and.screwdriver")
                        Text("Settings")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
