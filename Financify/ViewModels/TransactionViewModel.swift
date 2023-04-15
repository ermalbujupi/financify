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
    
    init(databaseService: FirebaseService = FirebaseService.shared) {
        self.databaseService = databaseService
        loadTransactions()
    }
    
    private func loadTransactions() {
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
}
