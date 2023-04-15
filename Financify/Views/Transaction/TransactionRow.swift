//
//  TransactionRow.swift
//  Financify
//
//  Created by Ermal Bujupaj on 15.04.23.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.category.name)
                    .font(.headline)
                Text(transaction.type.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text("\(transaction.amount, specifier: "%.2f")")
                .font(.callout)
                .foregroundColor(transaction.amount >= 0 ? .green : .red)
        }
    }
}
