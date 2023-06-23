import SwiftUI

struct InterestTagComponent: View {
    let interest: String
    @Binding var selectedInterests: [String]
    
    var isSelected: Bool {
        selectedInterests.contains(interest)
    }
    
    var body: some View {
        Button(
            action: {
                toggleSelected()
            }
        ) {
            Text(interest)
                .foregroundColor(isSelected ? .white : .primary)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 22)
        .background(isSelected ? Color.accentColor : Color(.systemGray5))
        .clipShape(Capsule())
    }
    
    func toggleSelected() {
        if isSelected {
            selectedInterests.removeAll(where: { $0 == interest })
        } else {
            if selectedInterests.count < 5 {
                selectedInterests.append(interest)
            }
        }
    }
}
