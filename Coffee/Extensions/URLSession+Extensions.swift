// URLSession+Extensions.swift
// Copyright (c) 2020 Joe Blau

import Foundation

enum URLSessionError: Error {
    case httpStatusError
    case imageDecodingError
}

extension URLSession {
    static var sharedSession: URLSession = {
        let cacheMemorySize = 1000 * 1024 * 1024
        let cacheDiskSize = 1000 * 1024 * 1024

        let c = URLSessionConfiguration.default
        c.requestCachePolicy = .returnCacheDataElseLoad
        c.urlCache = URLCache(memoryCapacity: cacheMemorySize, diskCapacity: cacheDiskSize)
        c.httpMaximumConnectionsPerHost = 1
        return URLSession(configuration: c)
    }()
}
