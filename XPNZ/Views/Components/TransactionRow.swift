import SwiftUI

/// A single transaction row in the list
struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon in rounded rectangle with light grey background
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray6))
                    .frame(width: 36, height: 36)
                
                Image(systemName: transaction.iconName)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.black)
            }
            
            // Name and type
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.name)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(transaction.type.rawValue)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Amount - light grey, not bold
            Text(transaction.formattedAmount)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundColor(Color(.systemGray))
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    VStack {
        TransactionRow(transaction: MockTransactions.monthlyTransactions[0])
        TransactionRow(transaction: MockTransactions.monthlyTransactions[2])
        TransactionRow(transaction: MockTransactions.monthlyTransactions[3])
    }
    .padding()
}
