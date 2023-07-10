//
//  RemoveTrailingZero.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-07-10.
//

import Foundation

func removeTrailingZero(_ value: Double) -> String {
    let roundedValue = (value * 10).rounded() / 10 // Round to first decimal point
    
    if roundedValue.truncatingRemainder(dividingBy: 1) == 0 {
        return String(format: "%.0f", roundedValue) // Remove .0 from whole numbers
    } else {
        return String(format: "%.1f", roundedValue) // Format with one decimal point
    }
}
