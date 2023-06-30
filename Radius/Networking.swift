//
//  Networking.swift
//  Radius
//
//  Created by Nagaraj V Rao on 28/06/23.
//

import Foundation
import Combine

final class Networking {
    
    typealias SwiftError = Swift.Error
    
    enum Error: SwiftError {
        case invalidURL
        case requestFailed(SwiftError)
        case invalidResponse
        case decodingFailed(SwiftError)
        case statusCode(Int)
    }
    
    static let shared = Networking()
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func loadFacilities(urlString: String = "https://my-json-server.typicode.com/iranjith4/ad-assignment/db",
                        decoder: JSONDecoder = .init()) -> AnyPublisher<FacilitiesResponse, Networking.Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: Networking.Error.invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .mapError { error -> Error in
                Networking.Error.requestFailed(error)
            }
            .flatMap { data, response -> AnyPublisher<FacilitiesResponse, Error> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: Networking.Error.invalidResponse).eraseToAnyPublisher()
                }
                
                if (200...299).contains(httpResponse.statusCode) {
                    return Just(data)
                        .decode(type: FacilitiesResponse.self, decoder: decoder)
                        .mapError { error -> Error in
                            Networking.Error.decodingFailed(error)
                        }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: Networking.Error.statusCode(httpResponse.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

