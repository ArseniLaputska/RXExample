//
//  University.swift
//  ReactiveR
//
//  Created by Arseni Laputska on 10.11.22.
//

import Foundation

struct Universities: Decodable {
    let universities: [University]
}

struct University: Decodable, CustomStringConvertible {
    
    let web_pages: [String]
    let country: String
    let name: String
    
    var description: String {
        return "\(name) based in \(country). Tap to discover more!"
    }
    
    init(web_pages: [String], country: String, name: String) {
        self.web_pages = web_pages
        self.country = country
        self.name = name
    }
}
