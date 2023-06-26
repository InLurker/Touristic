//
//  TouristicApp.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-06-22.
//

import SwiftUI

@main
struct TouristicApp: App {
    @AppStorage("isOnBoardingCompleted") var isOnBoardingCompleted: Bool = false
    var body: some Scene {
        WindowGroup {
            if(isOnBoardingCompleted) {
                OnBoardingView()
            } 
            else {
                TabBarView()
            }
        }
    }
}
