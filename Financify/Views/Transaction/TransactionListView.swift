//
//  TransactionListView.swift
//  Financify
//
//  Created by Ermal Bujupaj on 13.04.23.
//

import SwiftUI

struct TransactionListView: View {
    
    @ObservedObject var viewModel = TransactionViewModel()
    
    @State private var showingTransactionForm = false
    
    var body: some View {
        NavigationView {
            VStack {
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
                        Section {
                            ForEach(viewModel.transactions, id: \.id) { transaction in
                                TransactionRow(transaction: transaction)
                            }
                            .onDelete(perform: viewModel.deleteTransaction)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingTransactionForm.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingTransactionForm) {
                TransactionFormView(viewModel: viewModel)
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
