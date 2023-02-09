//
//  NetworkManager.swift
//  ReactiveR
//
//  Created by Arseni Laputska on 10.11.22.
//

import Foundation
import RxSwift

class NetworkManager {
    private let apiClient = NetworkClient()
    
    func getCountry(with country: String) -> Observable<[University]> {
        let request = ModelRequest(name: country)
        
        return apiClient.send(apiRequest: request, type: [University].self)
    }
    
    func getCountries(with countries: [String] = ["Poland", "Canada", "Ukraine", "Belarus", "Latvia"]) -> Observable<[University]> {
        let observables = countries.map { getCountry(with: $0) }
        
        return Observable.merge(observables)
    }
}
