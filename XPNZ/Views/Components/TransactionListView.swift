import SwiftUI

/// Fixed-height scrollable transaction list - no dividers
struct TransactionListView: View {
    let transactions: [Transaction]
    let selectedCategory: TransactionCategory
    
    /// Filter transactions based on selected category (mock filtering for now)
    private var filteredTransactions: [Transaction] {
        switch selectedCategory {
        case .all:
            return transactions
        case .topSpends:
            return transactions
                .filter { !$0.isIncoming }
                .sorted { $0.amount > $1.amount }
                .prefix(5)
                .map { $0 }
        case .recurring:
            return transactions.filter { $0.type == .subscription }
        default:
            return transactions
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(spacing: 0) {
                ForEach(filteredTransactions) { transaction in
                    TransactionRow(transaction: transaction)
                }
            }
        }
        .frame(height: 280)
    }
}

#Preview {
    TransactionListView(
        transactions: MockTransactions.monthlyTransactions,
        selectedCategory: .all
    )
    .padding()
}
