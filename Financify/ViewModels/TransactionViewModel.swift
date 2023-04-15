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
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadTransactions()
    }
    
    private func loadTransactions() {
        
    }
}
