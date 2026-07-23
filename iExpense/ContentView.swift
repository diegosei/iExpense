//
//  ContentView.swift
//  iExpense
//
//  Created by Diego Seitler on 08/07/2026.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    var amount: Double
    
    var amountStyle: Color {
        switch amount {
        case ..<10: .green
        case 10..<100: .orange
        case 100..<1000: .red
        default: .black
        }
    }
}

struct Categories {
    let category = [String]()
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "newItems")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "newItems") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
}
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    
    var body: some View {
        NavigationStack() {
            List {
                Section("Personal Expenses") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack {
                                    Text(item.name)
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: currencyCode))
                                    .foregroundStyle(item.amountStyle)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                    
                }
                Section("Business Expenses") {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack {
                                    Text(item.name)
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: currencyCode))
                                    .foregroundStyle(item.amountStyle)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink("Add") {
                    AddView(expenses: expenses)
                }
            }
        }
    }
    func removeItems(at offIndex: IndexSet) {
        expenses.items.remove(atOffsets: offIndex)
    }
}

#Preview {
    ContentView()
}
