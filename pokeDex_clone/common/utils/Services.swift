//
//  Services.swift
//  pokéDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/25.
//

import Foundation


class Services {
    public static let defaults = Services()
    private var request: URLRequest
    private init() {
        request = URLRequest(url: URL(string: "http://www.naver.com")!, cachePolicy: .returnCacheDataElseLoad)
    }
    
    func fetchImage (_ urlString: String, tableCell: FavoriteTableViewCell?, collectionCell: ListCollectionViewCell?) {
        let url = URL(string: urlString)
        request.url = url
        request.httpMethod = "GET"
        print("fetch")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let imgData = data else {return}
                DispatchQueue.main.async {
                    if let tCell = tableCell {
                        tCell.setImage(data: imgData)
                    }
                    if let cCell = collectionCell {
                        cCell.setImage(data: imgData)
                    }
                }
                
            }
        }.resume()
    }
    
    
    
}
