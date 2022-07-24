//
//  Queue.swift
//  
//
//  Created by Marquis Kurt on 24/7/22.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Foundation

/// A class that represents a queue data structure (FIFO).
public class Queue<Element> {
    private var queue = [Element]()

    public init() {}

    /// Whether the queue is empty.
    public var isEmpty: Bool { queue.isEmpty }

    /// The size of the queue.
    public var count: Int { queue.count }

    /// The size of the queue.
    /// - Important: This property has been renamed to ``count`` to be consistent with other collections.
    @available(*, deprecated, renamed: "count")
    public var size: Int { queue.count }

    /// The first element of the queue.
    public var first: Element? { queue.first }

    /// The front of the queue.
    /// - Important: This property has been renamed to ``first`` to be consistent with other collections.
    @available(*, deprecated, renamed: "first")
    public var front: Element? { queue.first }

    /// The last element of the queue.
    public var last: Element? { queue.last }

    /// The back of the queue.
    /// - Important: This property has been renamed to ``last`` to be consistent with other collections.
    @available(*, deprecated, renamed: "last")
    public var back: Element? { queue.last }

    /// Enqueue an item into the queue.
    /// - Parameter element: The item to add to the queue.
    public func enqueue(_ element: Element) {
        queue.append(element)
    }

    /// Dequeue an item from the queue.
    /// - Returns: The dequeued item, or nil if the queue is empty.
    public func dequeue() -> Element? {
        queue.removeFirst()
    }
}
