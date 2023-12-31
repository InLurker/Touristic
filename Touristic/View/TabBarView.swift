//
//  TabBarView.swift
//  Touristic
//
//  Created by Billy Jefferson on 23/06/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView{
            ExploreView().tabItem{
                Label("Explore", systemImage: "safari")
            }
            PinnedView().tabItem{
                Label("Pinned", systemImage: "pin")
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
