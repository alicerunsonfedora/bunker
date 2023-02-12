//
//  Collection+IsNotEmpty.swift
//  
//
//  Created by Marquis Kurt on 2/12/23.
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Foundation

public extension Collection {
    /// A Boolean value indicating whether the collection contains elements.
    var isNotEmpty: Bool { !isEmpty }
}
