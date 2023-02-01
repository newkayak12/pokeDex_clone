//
//  Services.swift
//  pokéDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/25.
//

import Foundation


class Services {
    public static let defaults = Services()
    
    private init() {
    }
    
    func fetchImage (_ urlString: String) -> Data? {
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        var result: Data?
        print("fetch")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print(data)
                result = data
                
            }
        }.resume()
        
        
        return result
    }
    
    
    
}
