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
    }
    func fetchData() {
        let repository = PokeRepository()
        tableData = repository.selectWhereFavorite()
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
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "HI"
        cell.backgroundColor = .yellow
        return cell
    }
}
