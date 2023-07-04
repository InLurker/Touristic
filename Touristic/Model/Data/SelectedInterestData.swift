//
//  SelectedInterestData.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-07-03.
//

import Foundation

class SelectedInterestData: ObservableObject {
    static let shared = SelectedInterestData() // Singleton instance

    @Published var selectedInterests: [String] = []

    private init() {
        getSelectedInterests()
    }

    // Save the selectedInterests array to UserDefaults
    func saveSelectedInterests() {
        UserDefaults.standard.set(selectedInterests, forKey: "selectedInterests")
    }

    // Retrieve the selectedInterests array from UserDefaults
    private func getSelectedInterests() {
        if let selectedInterests = UserDefaults.standard.array(forKey: "selectedInterests") as? [String] {
            self.selectedInterests = selectedInterests
        }
    }
}
