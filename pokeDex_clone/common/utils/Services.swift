//
//  Services.swift
//  pokéDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/25.
//

import Foundation


class Services {
    public let defaults = Services()
    
    private let session = URLSession(configuration: .default)
    private init() {
        
    }
    
    func fetchData (_ page: Int) {
        let baseUrl = "https://www.pokemonkorea.co.kr/ajax/pokedex?mode=load_more&pn=\(page)&snumber=1&snumber2=1008&sortselval=number asc,number_count asc"
        
        if let url = URL(string: baseUrl) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("text/html; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            session.dataTask(with: urlRequest) { (data, response, error) in
                print("")
            }
        }
        
    }
    
    
    
}
