import SwiftUI

let tagList = [
    TagModel(name: "Hiking"),
    TagModel(name: "Surfing"),
    TagModel(name: "Camping"),
    TagModel(name: "Picnic"),
    TagModel(name: "Sport"),
    TagModel(name: "Entertainment"),
    TagModel(name: "Dancing"),
    TagModel(name: "Shopping"),
    TagModel(name: "Healing"),
    TagModel(name: "Swimming"),
    TagModel(name: "Spiritual"),
    TagModel(name: "Cycling"),
    TagModel(name: "Snorkeling"),
    TagModel(name: "Diving"),
    TagModel(name: "Climbing"),
    TagModel(name: "Recreation"),
    TagModel(name: "Night Life"),
    TagModel(name: "Local"),
    TagModel(name: "Photography"),
    TagModel(name: "Aquatic Recreation"),
    TagModel(name: "Culinary"),
    TagModel(name: "Historical"),
    TagModel(name: "Gardening")
]

struct OnBoardingView: View {
    @State private var selectedInterests: [String] = []
    
    var body: some View {
        NavigationStack() {
            VStack(alignment: .leading) {
                Text("Select up to 5")
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                WrappingHStack(models: tagList, viewGenerator: { tag in
                    InterestTagComponent(
                        interest: tag.name,
                        selectedInterests: $selectedInterests
                    )
                })
                .horizontalSpacing(6)
                .verticalSpacing(6)
                
                Spacer()
                
                Button(
                    action: {
                        // TODO: Perform action when "Next" button is tapped
                        print(selectedInterests)
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
                            // TODO: Perform action when "Skip to Explore" button is tapped
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
