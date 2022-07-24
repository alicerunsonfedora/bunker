//
//  Stack.swift
//  
//
//  Created by Marquis Kurt on 24/7/22.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Foundation

/// A class that represents a queue data structure (LIFO).
public class Stack<Element> {
    private var stack = [Element]()

    public init() {}

    /// Whether the stack is empty.
    public var isEmpty: Bool { stack.isEmpty }

    /// The size of the stack.
    public var count: Int { stack.count }

    /// The size of the stack.
    /// - Important: This property has been renamed to ``count`` to be consistent with other collections.
    @available(*, deprecated, renamed: "count")
    public var size: Int { stack.count }

    /// The top of the stack.
    public var top: Element? { stack.last }

    /// Pushes an element on to the stack.
    /// - Parameter element: The element to push on the stack.
    public func push(_ element: Element) {
        stack.append(element)
    }

    /// Pops an element from the stack.
    /// - Returns: The popped element from the stack, or nil if the stack is empty.
    public func pop() -> Element {
        stack.removeLast()
    }
}
