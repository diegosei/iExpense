//
//  ExpenseItemsView.swift
//  iExpense
//
//  Created by Diego Seitler on 24/07/2026.
//

import SwiftUI
import SwiftData

struct ExpenseItemsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenseItems: [ExpenseItem]
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        List {
            ForEach(expenseItems) { item in
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
            .onDelete(perform: removeItems)
        }
    }
    
    init(filter: ExpenseItem.FilterType, sortOrder: [SortDescriptor<ExpenseItem>]) {
        switch filter {
            case .all:
                _expenseItems = Query(sort: sortOrder)

            case .personal:
                _expenseItems = Query(
                    filter: #Predicate<ExpenseItem> { type in
                        type.type == "Personal" },
                    sort: sortOrder
                )

            case .business:
                _expenseItems = Query(
                    filter: #Predicate<ExpenseItem> { type in
                        type.type == "Business" },
                    sort: sortOrder
                )
            }
    }
    
    func removeItems(offSets: IndexSet) {
        for offSet in offSets {
            modelContext.delete(expenseItems[offSet])
        }
    }
}

#Preview {
    ExpenseItemsView(filter: .personal, sortOrder: [SortDescriptor(\ExpenseItem.type)])
        .modelContainer(for: ExpenseItem.self)
}
