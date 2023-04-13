//
//  Transaction.swift
//  Financify
//
//  Created by Ermal Bujupaj on 13.04.23.
//

import Foundation

struct Transaction: Identifiable, Codable {
    var id: String
    var type: TransactionType
    var category: Category
    var amount: Double
    var currency: String
    var date: Date
    var note: String?
    var receiptImage: String? // Store the image file name or URL
}

enum TransactionType: String, Codable {
    case income
    case expense
}
