//
//  Category.swift
//  Financify
//
//  Created by Ermal Bujupaj on 13.04.23.
//

import Foundation

struct Category: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var type: TransactionType
    var iconName: String
}
