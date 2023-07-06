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
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            if(isOnBoardingCompleted) {
                TabBarView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            } 
            else {
                OnBoardingView()
            }
        }
    }
}
