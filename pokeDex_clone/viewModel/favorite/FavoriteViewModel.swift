//
//  FavoriteViewModel.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/31.
//

import Foundation
import UIKit
class FavoriteViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var tableData: [PokeEntity]?
    
    override init() {
        super.init()
        let repository = PokeRepository()
        tableData = repository.selectAll()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(#function)
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        guard let tableData = tableData else {return 0}
        return tableData.count
//        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let pokeData = tableData else {return cell}
        guard let customCell = cell as? FavoriteTableViewCell else {
            print("ERROR")
            return cell
        }
        
        
        let poke = pokeData[indexPath.row]
        customCell.pokeLabel.text = poke.pokeName
        guard let likeStatus = poke.like else { fatalError()}
        
        
        let url = URL(string: poke.imgSrc!)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async { 
                    if let result = data{
                        customCell.pokeImg.image = UIImage(data: result)
                    }
                }
            }
        }.resume()
        customCell.accessoryView = UIImageView(image: UIImage(systemName: likeStatus ? customCell.like : customCell.unlike))
//        customCell.accessoryType = .none
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
