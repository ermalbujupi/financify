//
//  TransactionViewModel.swift
//  Financify
//
//  Created by Ermal Bujupaj on 13.04.23.
//

import SwiftUI
import Combine

class TransactionViewModel: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    @Published var filteredTransactions: [Transaction] = []

    @Published var isLoading = false
    @Published var error: Error? = nil
    
    private var databaseService: FirebaseService
    private var cancellables = Set<AnyCancellable>()
    
    let defaultCategories: [Category] = [
        Category(id: "1", name: "Food", type: .expense, iconName: "cart.fill"),
        Category(id: "2", name: "Social Life", type: .expense, iconName: "person.2.fill"),
        Category(id: "3", name: "Health", type: .expense, iconName: "heart.fill"),
        Category(id: "4", name: "Entertainment", type: .expense, iconName: "gamecontroller.fill"),
        // Add more categories as needed
    ]
    
    init(databaseService: FirebaseService = FirebaseService.shared) {
        self.databaseService = databaseService
        loadTransactions()
    }
    
    public func loadTransactions() {
        isLoading = true
        FirebaseService.shared.fetchTransactions()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { transactions in
                self.transactions = transactions
                self.filteredTransactions = transactions
            }
            .store(in: &cancellables)
    }
    
    public func addTransaction(_ transaction: Transaction) {
        isLoading = true
        databaseService.addTransaction(transaction)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    self.loadTransactions()
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    public func deleteTransaction(at offsets: IndexSet) {
        let transaction = transactions[offsets.first!]
        
        databaseService.deleteTransaction(withId: transaction.id) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.transactions.remove(atOffsets: offsets)
                }
            case .failure(let error):
                print("Error deleting the transaction: \(error)")
            }
        }
    }
}
