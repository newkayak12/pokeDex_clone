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
    private var page = 1
    private lazy var baseUrl = {
        "https://www.pokemonkorea.co.kr/ajax/pokedex?mode=load_more&pn=\(self.page)&snumber=1&snumber2=1008&sortselval=number asc,number_count asc"
    }()
    let urlRequest: URLRequest?
    private init() {
        if let url = URL(string: self.baseUrl) {
            urlRequest = URLRequest(url: url)
            urlRequest?.httpMethod = "POST"
            urlRequest?.addValue("text/html; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        }
    }
    
    func fetchData (_ page: Int) {
        self.page = page;
        guard let urlRequest = self.urlRequest else {fatalError()}
        session.dataTask(with: urlRequest) { (data, response, error) in
            <#code#>
        }
    }
    
    
    
}
