//
//  CoffeeAPIController.swift
//  Coffee
//
//  Created by Joe Blau on 4/1/20.
//  Copyright © 2020 Joe Blau. All rights reserved.
//

import Foundation
import Combine

struct CoffeeGroup: Codable {
    var id: UUID
    var name: String
    var imageUrl: String
    var timeZone: String
}

class CoffeeAPIController {
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()
    
    private var components: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "coffeecoffeecoffee.coffee"
        components.path = "/api/groups/"
        return components
    }()
    
    func groups() -> AnyPublisher<[CoffeeGroup], Error> {
        guard let url = components.url else { fatalError() }
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
}


