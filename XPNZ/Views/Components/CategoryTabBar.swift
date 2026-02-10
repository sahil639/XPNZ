import SwiftUI

/// Horizontal scrollable category tabs
struct CategoryTabBar: View {
    @Binding var selectedCategory: TransactionCategory
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(TransactionCategory.allCases) { category in
                    CategoryTab(
                        title: category.rawValue,
                        isSelected: selectedCategory == category
                    ) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedCategory = category
                        }
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }
}

/// Individual category tab button
struct CategoryTab: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 13, weight: isSelected ? .semibold : .regular, design: .rounded))
                .foregroundColor(isSelected ? .primary : .secondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color(.systemGray5) : Color.clear)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CategoryTabBar(selectedCategory: .constant(.all))
        .padding()
}
