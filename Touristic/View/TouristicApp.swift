//
//  TouristicApp.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-06-22.
//

import SwiftUI

@main
struct TouristicApp: App {
    var body: some Scene {
        WindowGroup {
            if(true) {
                OnBoardingView()
            } 
            else {
                TabBarView()
            }
        }
    }
}
