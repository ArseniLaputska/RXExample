//
//  ModelRequest.swift
//  ReactiveR
//
//  Created by Arseni Laputska on 10.11.22.
//

import Foundation

class ModelRequest: ApiRequest {
    var method = "GET"
    var path = ""
    var parameters = [String: String]()
    
    init(name: String) {
        parameters["country"] = name
    }
}

