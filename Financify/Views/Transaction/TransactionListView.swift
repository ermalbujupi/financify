//
//  TransactionListView.swift
//  Financify
//
//  Created by Ermal Bujupaj on 13.04.23.
//

import SwiftUI

struct TransactionListView: View {
    
    @ObservedObject var viewModel = TransactionViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.error {
                    VStack {
                        Text("Error: \(error.localizedDescription)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Retry") {
                            viewModel.loadTransactions()
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ForEach(viewModel.transactions, id: \.id) { transaction in
                        TransactionRow(transaction: transaction)
                    }
                }
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
