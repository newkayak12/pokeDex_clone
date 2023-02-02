//
//  ListViewModel.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/02/01.
//

import Foundation

class ListViewModel: NSObject {
    var collectionData: [PokeEntity]?
    let pokeRepo = PokeRepository()
    
    override init() {
        super.init()
    }
    
    func search (searchText: String){
        if searchText == "" {
            collectionData = pokeRepo.selectAll()
        } else {
            collectionData = pokeRepo.selectWhereName(searchText: searchText)
        }
    }
    
}

