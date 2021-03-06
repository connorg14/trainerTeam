//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation

/// Error Handler function typealias
public typealias DataStoreErrorHandler = (AmplifyError) -> Void

/// Holds a reference to both the local `Model` and the remote one during a conflict
/// resolution. Implementations of the `DataStoreConflictHandler` use this to decide
/// what the outcome of a conflict should be.
public struct DataStoreConflictData {
    public let local: Model
    public let remote: Model
}

/// The `DataStoreConflictHandler` is an asynchronous callback which allows consumers to decide how to resolve conflicts
/// between the frontend and backend. This can be configured on the `conflictHandler` of the `DataStoreConfiguration`
/// by implementing the body of the closure, processing `DataStoreConflictData` and resolving the conflict by calling
/// `DataStoreConflictHandlerResolver`
public typealias DataStoreConflictHandler = (DataStoreConflictData, @escaping DataStoreConflictHandlerResolver) -> Void

/// Callback for the `DataStoreConflictHandler`.
public typealias DataStoreConflictHandlerResolver = (DataStoreConflictHandlerResult) -> Void

/// The conflict resolution result enum.
public enum DataStoreConflictHandlerResult {

    /// Discard the local changes in favor of the remote ones. Semantically the same as `DISCARD` on Amplify-JS
    case applyRemote

    /// Keep the local changes. (semantic shortcut to `retry(local)`).
    case retryLocal

    /// Return a new `Model` instance that should used instead of the local and remote changes.
    case retry(Model)
}

/// The `DataStore` plugin configuration object.
public struct DataStoreConfiguration {

    /// A callback function called on unhandled errors
    public let errorHandler: DataStoreErrorHandler

    /// A callback called when a conflict could not be resolved by the service
    public let conflictHandler: DataStoreConflictHandler

    /// How often the sync engine will run (in seconds)
    public let syncInterval: TimeInterval

    /// The number of records to sync per execution
    public let syncMaxRecords: UInt

    /// The page size of each sync execution
    public let syncPageSize: UInt

    init(errorHandler: @escaping DataStoreErrorHandler,
         conflictHandler: @escaping DataStoreConflictHandler,
         syncInterval: TimeInterval,
         syncMaxRecords: UInt,
         syncPageSize: UInt) {
        self.errorHandler = errorHandler
        self.conflictHandler = conflictHandler
        self.syncInterval = syncInterval
        self.syncMaxRecords = syncMaxRecords
        self.syncPageSize = syncPageSize
    }

}

extension DataStoreConfiguration {

    public static let defaultSyncInterval: TimeInterval = .hours(24)
    public static let defaultSyncMaxRecords: UInt = 10_000
    public static let defaultSyncPageSize: UInt = 1_000

    /// Creates a custom configuration. The only required property is `conflictHandler`.
    ///
    /// - Parameters:
    ///   - errorHandler: a callback function called on unhandled errors
    ///   - conflictHandler: a callback called when a conflict could not be resolved by the service
    ///   - syncInterval: how often the sync engine will run (in seconds)
    ///   - syncMaxRecords: the number of records to sync per execution
    ///   - syncPageSize: the page size of each sync execution
    /// - Returns: an instance of `DataStoreConfiguration` with the passed parameters.
    public static func custom(
        errorHandler: @escaping DataStoreErrorHandler = { error in
            Amplify.Logging.error(error: error)
        },
        conflictHandler: @escaping DataStoreConflictHandler = { _, resolve  in
            resolve(.applyRemote)
        },
        syncInterval: TimeInterval = DataStoreConfiguration.defaultSyncInterval,
        syncMaxRecords: UInt = DataStoreConfiguration.defaultSyncMaxRecords,
        syncPageSize: UInt = DataStoreConfiguration.defaultSyncPageSize
    ) -> DataStoreConfiguration {
        return DataStoreConfiguration(errorHandler: errorHandler,
                                      conflictHandler: conflictHandler,
                                      syncInterval: syncInterval,
                                      syncMaxRecords: syncMaxRecords,
                                      syncPageSize: syncPageSize)
    }

    /// The default configuration.
    public static var `default`: DataStoreConfiguration {
        .custom()
    }

}
