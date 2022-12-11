//
//  ApiRequest.swift
//  ReactiveR
//
//  Created by Arseni Laputska on 10.11.22.
//

import Foundation
import UIKit

protocol ApiRequest {
    var method: String { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

extension ApiRequest {
    func request(wtih url: URL) -> URLRequest {
        guard var components = URLComponents(url: url.appendingPathExtension(path), resolvingAgainstBaseURL: false) else { fatalError("Unable create URL components") }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let url = components.url else { fatalError("Invalid url") }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
