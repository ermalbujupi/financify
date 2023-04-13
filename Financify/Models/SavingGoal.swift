//
//  SavingGoal.swift
//  Financify
//
//  Created by Ermal Bujupaj on 13.04.23.
//

import Foundation

struct SavingGoal: Identifiable, Codable {
    var id: String
    var name: String
    var targetAmount: Double
    var currentAmount: Double
    var targetDate: Date?
    var iconName: String // The icon's name or URL
}
