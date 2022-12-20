//
//  Comparable+Clamped.swift
//  
//
//  Created by Marquis Kurt on 24/7/22.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Foundation

public extension Comparable {
    /// Returns a value that exists within the range specified by its bounds.
    /// - Parameter lower: The lower bound of the range.
    /// - Parameter upper: The upper bound of the range.
    func clamp(lower: Self, upper: Self) -> Self {
        switch self {
        case self where self < lower: return lower
        case self where self > upper: return upper
        default: return self
        }
    }

    /// Returns a value that exists within the range specified by its bounds.
    ///
    /// - SeeAlso: ``clamp(lower:upper)``
    ///
    /// - Parameter range: The range the value must exist within.
    func clamp(to range: Range<Self>) -> Self {
        clamp(lower: range.lowerBound, upper: range.upperBound)
    }
}

/// A property wrapper that clamps comparable values to a range within a lower and upper bound.
/// Properties that utilize this wrapper will be clamped within the specified range when assigned or changed.
@propertyWrapper
public struct Clamped<Value: Comparable> {
    var value: Value
    var lowerBound: Value
    var upperBound: Value

    public var wrappedValue: Value {
        get { value }
        set { value = newValue.clamp(lower: lowerBound, upper: upperBound) }
    }

    init(wrappedValue: Value, lowerBound: Value = 0, upperBound: Value) {
        self.value = wrappedValue
        self.lowerBound = lowerBound
        self.upperBound = upperBound
    }
}
