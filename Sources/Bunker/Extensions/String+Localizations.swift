//
//  String+Localizations.swift
//  
//
//  Created by Marquis Kurt on 2/12/23.
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Foundation

public extension String {
    /// Returns the localized string using itself as the key.
    /// - Parameter comment: A comment that describes this string. Use this to let translators know the purpose of this string.
    func localized(comment: String = "") -> String {
        NSLocalizedString(self, comment: comment)
    }

    /// Returns a formatted localized string using itself as the key.
    /// - Parameter comment: A comment that describes this string. Use this to let translators know the purpose of this string.
    /// - Parameter arguments: The arguments that will be passed into the formatted string.
    func localized(comment: String = "", _ arguments: CVarArg...) -> String {
        Self.localizedStringWithFormat(self, arguments)
    }
}
