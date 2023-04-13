//
//  Budget.swift
//  Financify
//
//  Created by Ermal Bujupaj on 13.04.23.
//

import Foundation

struct Budget: Identifiable, Codable {
    var id: String
    var category: Category
    var amount: Double
    var startDate: Date
    var endDate: Date
}
