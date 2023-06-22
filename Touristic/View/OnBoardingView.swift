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
    var body: some View {
        NavigationStack()  {
            VStack {
                WrappingHStack(models: tagList, viewGenerator: { tag in
                    InterestTagComponent(
                        interest: tag.name
                    )
                })
                .horizontalSpacing(6)
                .verticalSpacing(6)
                Spacer()
            }
            .padding(.top, 50)
            .padding(.horizontal, 20)
            .navigationTitle(
                "Choose Your Interest"
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
