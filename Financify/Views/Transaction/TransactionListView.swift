//
//  TransactionListView.swift
//  Financify
//
//  Created by Ermal Bujupaj on 13.04.23.
//

import SwiftUI

struct TransactionListView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Transaction 1")
            }
            .navigationTitle("Transactions")
        }
        
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
