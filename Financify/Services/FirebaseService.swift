//
//  FirebaseService.swift
//  Financify
//
//  Created by Ermal Bujupaj on 13.04.23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift


class FirebaseService {
    
    static let shared = FirebaseService()
    
    private init() {}
    
    private let db = Firestore.firestore()
    private let transactionsCollection = "transactions"
    
    // MARK: Fetch transactions
    
    func fetchTransactions() -> Future<[Transaction], Error> {
        return Future { promise in
            let collection = self.db.collection(self.transactionsCollection)
            collection.getDocuments { querySnapshot, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                let transactions = querySnapshot?.documents.compactMap({ document -> Transaction? in
                    return try? document.data(as: Transaction.self)
                }) ?? []
                
                promise(.success(transactions))
            }
        }
    }
    
    // MARK: Add transaction
    
    func addTransaction(_ transaction: Transaction) -> Future<Void, Error> {
        return Future { promise in
            do {
                let _ = try self.db.collection(self.transactionsCollection).addDocument(from: transaction) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }
    }
    
}
