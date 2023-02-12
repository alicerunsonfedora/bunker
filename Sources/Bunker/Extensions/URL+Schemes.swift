//
//  URL+Schemes.swift
//  
//
//  Created by Marquis Kurt on 2/12/23.
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Foundation

public extension URL {
    /// The URL's scheme or protocol.
    /// This is the text that appears first. Examples includes `http://`, `ftp://`, or `x-url-callback://`.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    var scheme: String? {
        guard let schemeRegex = try? Regex<String>(#"[a-zA-Z0-9\_\-]+\:\/\/"#) else { return nil }
        return absoluteString.firstMatch(of: schemeRegex)?.0
    }
}
