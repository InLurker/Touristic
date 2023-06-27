//
//  TripNameData.swift
//  Touristic
//
//  Created by Billy Jefferson on 26/06/23.
//

import Foundation
 

class TripNameSet: ObservableObject {
    static let shared = TripNameSet()
    @Published var tripNameSet: [String] = ["9","8"]
}

class TripActivitySet: ObservableObject {
    static let activityShared = TripActivitySet()
    @Published var tripActivity:[Int] = []
}
