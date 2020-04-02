//
//  CoffeeAPIController.swift
//  Coffee
//
//  Created by Joe Blau on 4/1/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import Foundation
import Combine

struct CoffeeGroup: Hashable, Codable {
    var id: UUID
    var name: String
    var imageUrl: URL
    var timeZone: String
}

struct GroupEvent: Hashable, Codable {
    var id: UUID
    var groupId: UUID
    var name: String
    var imageUrl: URL?
    var startAt: Date
    var endAt: Date
    var venue: Venue
}

struct Venue: Hashable, Codable {
    var name: String
    var url: URL
    var location: Location
}

struct Location: Hashable, Codable {
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
}

class CoffeeAPIController {
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        d.dateDecodingStrategy = .formatted(.iso8601Full)
        return d
    }()
    
    private var components: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "coffeecoffeecoffee.coffee"
        return components
    }()
    
    var groups: AnyPublisher<[CoffeeGroup], Error> {
        components.path = "/api/groups/"
        guard let url = components.url else { preconditionFailure("Invalid url") }
        let request = URLRequest(url: url)
        
        return URLSession.sharedSession
            .dataTaskPublisher(for: request)
            .tryMap { (data, response) -> [CoffeeGroup] in
                guard let httpReponse = response as? HTTPURLResponse,
                    httpReponse.statusCode == 200 else {
                        throw URLSessionError.httpStatusError
                }
                do {
                    return try self.decoder.decode([CoffeeGroup].self, from: data)
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
    
    func events(for id: UUID) -> AnyPublisher<[GroupEvent], Error> {
        components.path = "/api/groups/\(id.uuidString.lowercased())/events"
        guard let url = components.url else { preconditionFailure("Invalid url") }
        let request = URLRequest(url: url)
        
        return URLSession.sharedSession
            .dataTaskPublisher(for: request)
            .tryMap { (data, response) -> [GroupEvent] in
                guard let httpReponse = response as? HTTPURLResponse,
                    httpReponse.statusCode == 200 else {
                        throw URLSessionError.httpStatusError
                }
                do {
                    return try self.decoder.decode([GroupEvent].self, from: data)
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}


