//
//  ContentView.swift
//  iExpense
//
//  Created by Diego Seitler on 08/07/2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var expenseItems: [ExpenseItem]
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    @State private var filter: ExpenseItem.FilterType = .all
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.type),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    var body: some View {
        NavigationStack() {
            ExpenseItemsView(filter: filter, sortOrder: sortOrder)
            
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink("Add") {
                        AddView()
                    }
                    Menu("Sort by type", systemImage: "arrow.up.arrow.down") {
                        Button("All") {
                            filter = .all
                        }
                        Button("Personal") {
                            filter = .personal
                        }
                        Button("Business") {
                            filter = .business
                        }
                    }
                    Menu("Sort by name or amount", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)])
                            
                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name)])
                        }
                    }}
        }
    }
}

#Preview {
    ContentView()
}
