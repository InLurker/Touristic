import SwiftUI

struct InterestTagComponent: View {
    let interest: String
    @State var selected: Bool = false
    
    var body: some View {
        Button(
            action: {
                toggleSelected()
            }
        ) {
            Text(interest)
                .foregroundColor(selected ? .white : .primary)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 22)
        .background(selected ? Color.cyan : Color(.systemGray5))
        .clipShape(Capsule())
    }
    
    func toggleSelected() {
        selected.toggle()
    }
}
