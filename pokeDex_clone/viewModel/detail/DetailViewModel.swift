//
//  DetailViewModel.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/02/05.
//

import Foundation
class DetailViewModel {
    
    func changeLikeStatus (poke: PokeEntity) -> Bool {
        if PokeRepository().changeLike(poke: poke) > 0 {
            return !poke.like!
        }
        return poke.like!
    }
}
