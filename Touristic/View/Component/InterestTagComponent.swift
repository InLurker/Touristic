import SwiftUI

struct InterestTagComponent: View {
    let interestID: String
    @Binding var selectedInterests: [String]
    
    var isSelected: Bool {
        selectedInterests.contains(interestID)
    }
    
    var body: some View {
        Button(
            action: {
                toggleSelected()
            }
        ) {
            Text(interestDict[interestID]?.capitalized ?? "Interest")
                .foregroundColor(isSelected ? .white : .primary)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 22)
        .background(isSelected ? Color.accentColor : Color(.systemGray5))
        .clipShape(Capsule())
    }
    
    func toggleSelected() {
        if isSelected {
            selectedInterests.removeAll(where: { $0 == interestID })
        } else {
            if selectedInterests.count < 5 {
                selectedInterests.append(interestID)
            }
        }
    }
}
