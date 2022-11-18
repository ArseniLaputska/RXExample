//
//  NetworkClient.swift
//  ReactiveR
//
//  Created by Arseni Laputska on 10.11.22.
//

import Foundation
import RxSwift
import RxCocoa

class NetworkClient {
    let url = URL(string: "http://universities.hipolabs.com/search?country=")!
    
    private func send<T: Decodable>(apiRequest: ApiRequest, type: T.Type) -> Observable<T> {
        let request = apiRequest.request(wtih: url)
        return URLSession.shared.rx.data(request: request)
            .map { try JSONDecoder().decode(type, from: $0) }
    }
    
    func getCountry(with country: String) -> Observable<[University]> {
        let request = ModelRequest(name: country)
        return send(apiRequest: request, type: [University].self)
    }
    
    func countries() -> Observable<[University]> {
        return Observable.combineLatest(getCountry(with: "Poland"), getCountry(with: "Belarus"), getCountry(with: "Ukraine"), getCountry(with: "USA"), getCountry(with: "Latvia")).map { $0.0 + $0.1 + $0.2 + $0.3 + $0.4 }
    }
}
