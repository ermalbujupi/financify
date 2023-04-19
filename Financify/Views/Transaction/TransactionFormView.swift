//
//  TransactionFormView.swift
//  Financify
//
//  Created by Ermal Bujupaj on 15.04.23.
//

import SwiftUI

import SwiftUI

struct TransactionFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TransactionViewModel

    @State private var title = ""
    @State private var amount = ""
    @State private var transactionType: TransactionType = .income
    @State private var date = Date()
    @State private var selectedCategory: Category?

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                Picker("Type", selection: $transactionType) {
                    Text("Income").tag(TransactionType.income)
                    Text("Expense").tag(TransactionType.expense)
                }
                .pickerStyle(.automatic)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(viewModel.defaultCategories.filter { $0.type == transactionType }, id: \.id) { category in
                        HStack {
                            Image(systemName: category.iconName)
                            Text(category.name)
                        }.tag(category)
                    }
                }
                .pickerStyle(.automatic)
            }
            .navigationBarTitle("Add Transaction", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveTransaction()
                }
            )
        }
    }

    private func saveTransaction() {
        let transactionAmount = Double(amount) ?? 0.0
        let transaction = Transaction(id: UUID().uuidString, type: transactionType, category: selectedCategory!, amount: transactionAmount, currency: "EUR", date: date)
        viewModel.addTransaction(transaction)
        presentationMode.wrappedValue.dismiss()
    }
}

struct TransactionFormView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionFormView(viewModel: TransactionViewModel())
    }
}
