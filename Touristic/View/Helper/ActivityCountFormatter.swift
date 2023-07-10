//
//  activityCountFormatter.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-07-06.
//

import Foundation

func activityCountFormatter(count: Int) -> String {
    return String(count) + (count == 1 ? " Activity" : " Activities")
}
