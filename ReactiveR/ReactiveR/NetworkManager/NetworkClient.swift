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
    
    //async/await
    
    private func send<T: Decodable>(with request: ApiRequest, type: T.Type) async throws -> T {
        let request = request.request(wtih: url)
        let (data, _) = try await URLSession.shared.data(for: request)

        return try JSONDecoder().decode(type, from: data)
    }
    
    private func getUniversity(for country: String) async throws -> [University] {
        let request = ModelRequest(name: country)
        
        return try await send(with: request, type: [University].self)
    }
    
    func getCountries(with countries: [String]) async throws -> [University] {
        return try await withThrowingTaskGroup(of: [University].self, body: { taskGroup in
            var universities = [University]()
            for country in countries {
                taskGroup.addTask { return try await self.getUniversity(for: country) }
            }
            for try await university in taskGroup {
                universities.append(contentsOf: university)
            }
            return universities
        })
    }
    
    //rxswift
    private func send<T: Decodable>(apiRequest: ApiRequest, type: T.Type) -> Observable<T> {
        let request = apiRequest.request(wtih: url)
        
        return URLSession.shared.rx.data(request: request)
            .map { try JSONDecoder().decode(type, from: $0) }
    }
    
    private func getCountry(with country: String) -> Observable<[University]> {
        let request = ModelRequest(name: country)
        
        return send(apiRequest: request, type: [University].self)
    }
    
    func countries(with countries: [String]) -> Observable<[University]> {
        let observables = countries.map { getCountry(with: $0) }
        
        return Observable.merge(observables)
    }
}
