//
//  ExpenseItems.swift
//  iExpense
//
//  Created by Diego Seitler on 24/07/2026.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class ExpenseItem {
    var name: String
    var type: String
    var amount: Double
    
    var amountStyle: Color {
        switch amount {
        case ..<50: .green
        case 50..<100: .orange
        case 100...: .red
        default: .black
        }
    }
    
    enum FilterType {
        case all, personal, business
    }
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
