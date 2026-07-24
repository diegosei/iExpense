//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Diego Seitler on 08/07/2026.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
