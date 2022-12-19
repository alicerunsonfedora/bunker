//
//  URL+ScopedAccess.swift
//
//
//  Created by Marquis Kurt on 19/12/22.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Foundation

extension URL {
    /// Performs an action in a security scoped resource, starting and stopping access automatically.
    /// - Parameter action: The action to be performed in this context.
    /// - SeeAlso: `URL.startAccessingSecurityScopedResource`
    func accessInSecurityScopedResource(action: @escaping () -> Void) {
        _ = self.startAccessingSecurityScopedResource()
        action()
        self.stopAccessingSecurityScopedResource()
    }
}
