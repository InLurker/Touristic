import SwiftUI

struct OnBoardingView: View {
    @AppStorage("isOnBoardingCompleted") var isOnBoardingCompleted: Bool = false

    @StateObject private var selectedInterestData = SelectedInterestData.shared
    @State private var selectedInterests: [String] = []
    
    var body: some View {
        NavigationStack() {
            VStack(alignment: .leading) {
                Text("Select up to 5")
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                WrappingHStack(models: Array(interestDict.keys).sorted(), viewGenerator: { interestID in
                    InterestTagComponent(
                        interestID: interestID,
                        selectedInterests: $selectedInterests
                    )
                })
                .horizontalSpacing(6)
                .verticalSpacing(6)
                
                Spacer()
                
                Button(
                    action: {
                        UserDefaults.standard.set(selectedInterests, forKey: "selectedInterest")
                        isOnBoardingCompleted = true
                        
                        selectedInterestData.selectedInterests = selectedInterests
                        selectedInterestData.saveSelectedInterests()
                    }
                ) {
                    Spacer()
                    Text("Next")
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedInterests.isEmpty || selectedInterests.count > 5)
                
                HStack {
                    Spacer()
                    Button(
                        action: {
                            UserDefaults.standard.set(selectedInterests, forKey: "selectedInterest")
                            isOnBoardingCompleted = true
                        }
                    ) {
                        Text("Skip to Explore")
                            .underline()
                            .italic()
                    }
                    .buttonStyle(.automatic)
                    Spacer()
                }
                
            }
            .padding(.vertical, 50)
            .padding(.horizontal, 20)
            .navigationTitle("Choose Your Interest")
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
