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
    
    //rxswift
    func send<T: Decodable>(apiRequest: ApiRequest, type: T.Type) -> Observable<T> {
        let request = apiRequest.request(wtih: url)
        
        return URLSession.shared.rx.data(request: request)
            .map { try JSONDecoder().decode(type, from: $0) }
    }
}
