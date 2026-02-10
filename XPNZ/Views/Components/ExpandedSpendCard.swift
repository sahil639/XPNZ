import SwiftUI

/// Expanded card showing spend value with transaction details
struct ExpandedSpendCard: View {
    let spendData: SpendData
    let currency: Currency
    let onClose: () -> Void
    
    @State private var selectedCategory: TransactionCategory = .all
    @State private var isValueHidden: Bool = false
    
    private var transactions: [Transaction] {
        MockTransactions.transactions(for: spendData.timeFrame)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header with spend value and hide button - TAPPABLE to close
            headerView
                .padding(20)
                .background(Color(.systemGray6))
                .contentShape(Rectangle())
                .onTapGesture {
                    onClose()
                }
            
            // Category tabs and transaction list - white background
            VStack(alignment: .leading, spacing: 16) {
                // Category tabs
                CategoryTabBar(selectedCategory: $selectedCategory)
                
                // Subtle separator
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 1)
                
                // Transaction list
                TransactionListView(
                    transactions: transactions,
                    selectedCategory: selectedCategory
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 20)
            .background(Color(.systemBackground))
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
    
    private var headerView: some View {
        HStack(alignment: .center) {
            // Spend value (can be hidden)
            if isValueHidden {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text(currency.symbol)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .foregroundColor(.primary.opacity(0.6))
                    
                    Text("••••••")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text(spendData.timeFrame.displaySuffix)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .foregroundColor(.primary.opacity(0.5))
                }
            } else {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text(currency.symbol)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .foregroundColor(.primary.opacity(0.6))
                    
                    Text(spendData.formattedAmount)
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text(spendData.timeFrame.displaySuffix)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .foregroundColor(.primary.opacity(0.5))
                }
            }
            
            Spacer()
            
            // Hide/show value button - white icon on black background
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isValueHidden.toggle()
                }
            }) {
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 36, height: 36)
                    
                    Image(systemName: isValueHidden ? "eye" : "eye.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    ZStack {
        Color(.systemGray6)
            .ignoresSafeArea()
        
        ExpandedSpendCard(
            spendData: MockSpendingData.monthly,
            currency: .usd,
            onClose: {}
        )
        .padding(20)
    }
}
