//
//  Either.swift
//  
//
//  Created by Marquis Kurt on 24/7/22.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Foundation

/// A monadic sum type that can hold two types of data, simultaneousy.
///
/// The left side of the type houses a type that can result in being _failable_ in some way. Interpretation of failability
/// is up to developer implementation, but some common instances include a type throwing an error or optional types.
///
/// The right side contains a default type if the left side has failed for any given reason.
///
/// The Either type is akin to the Result and Optional types in how they function.
@frozen
public enum Either<Failable, Default> {

    /// The left hand side of the type, which may be failable. Stores a `Failable` type.
    case left(Failable)

    /// The right hand side of the type, which is guaranteed even if the left hand side fails. Stores a `Default` type.
    case right(Default)

    /// Returns a value after evaluating whether the type is on the left hand side or the right hand side.
    ///
    /// - Note: For concurrent environments, an asynchronous version of this method is also available.
    ///
    /// - Parameter failCase: A closure that returns a specified value if the type is on the left hand side.
    /// - Parameter defaultCase: A closure that returns a specified value if the type is on the right hand side.
    public func getEither<T>(failCase: (Failable) -> T, defaultCase: (Default) -> T) -> T {
        switch self {
        case let .left(fail):
            return failCase(fail)
        case let .right(def):
            return defaultCase(def)
        }
    }

    /// Returns a value after evaluating whether the type is on the left hand side or the right hand side.
    ///
    /// - Note: A synchronous version of this method is also available.
    ///
    /// - Parameter failCase: A closure that returns a specified value if the type is on the left hand side.
    /// - Parameter defaultCase: A closure that returns a specified value if the type is on the right hand side.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func getEither<T>(failCase: (Failable) async -> T, defaultCase: (Default) async -> T) async -> T {
        switch self {
        case let .left(fail):
            return await failCase(fail)
        case let .right(defaultType):
            return await defaultCase(defaultType)
        }
    }

    /// Performs an operation after evaluating whether the type is on the left hand side or the right hand side.
    ///
    /// - Parameter failCase: A closure that executes if the type is on the left hand side.
    /// - Parameter defaultCase: A closure that executes if the type is on the right hand side.
    public func doEither(failCase: (Failable) -> Void, defaultCase: (Default) -> Void) {
        switch self {
        case let .left(fail):
            failCase(fail)
        case let .right(defaultType):
            defaultCase(defaultType)
        }
    }

    /// Performs an operation when the type is on the left hand side.
    ///
    /// If the type is on the right hand side, the closure specified does not execute.
    /// - SeeAlso: ``doEither(failCase:defaultCase:)``
    ///
    /// - Parameter action: A closure that executes when the type is on the left hand side.
    public func doFailable(action: (Failable) -> Void) {
        doEither(failCase: action) { _ in }
    }

    /// Performs an operation when the type is on the right hand side.
    ///
    /// If the type is on the left hand side, the closure specified does not execute.
    /// - SeeAlso: ``doEither(failCase:defaultCase:)``
    ///
    /// - Parameter action: A closure that executes when the type is on the right hand side.
    public func doDefault(action: (Default) -> Void) {
        doEither(failCase: { _ in }, defaultCase: action)
    }


    /// Returns a new Either type by transforming the left hand side.
    ///
    /// If the type is on the right hand side, no transform occurs.
    /// - SeeAlso: ``mapDefault(transform:)``
    ///
    /// - Parameter transform: A closure that returns a new value if the type is on the left hand side.
    /// - Returns: A new Either type that contains the new type and the original default.
    @inlinable
    public func mapFailable<NewFailable>(transform: (Failable) -> NewFailable) -> Either<NewFailable, Default> {
        switch self {
        case let .left(failable):
            return .left(transform(failable))
        case let .right(defaultType):
            return .right(defaultType)
        }
    }

    /// Returns a new Either type by transforming the right hand side.
    ///
    /// If the type is on the left hand side, no transform occurs.
    /// - SeeAlso: ``mapFailable(transform:)``
    ///
    /// - Parameter transform: A closure that returns a new value if the type is on the right hand side.
    /// - Returns: A new Either type that contains the original failable type and the new default.
    @inlinable
    public func mapDefault<NewDefault>(transform: (Default) -> NewDefault) -> Either<Failable, NewDefault> {
        switch self {
        case let .left(failable):
            return .left(failable)
        case let .right(defaultType):
            return .right(transform(defaultType))
        }
    }
}

// MARK: - Equatable and Hashable Conformances

extension Either: Equatable where Failable: Equatable, Default: Equatable {}

extension Either: Hashable where Failable: Hashable, Default: Hashable {}
