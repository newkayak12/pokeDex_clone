//
//  poké.swift
//  pokéDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/25.
//

import Foundation
import SQLite3

class PokeEntity: Codable {
    var no: Int?;
    var pokeNo: Int?;
    var pokeName: String?;
    var imgSrc: String?;
    var weight: String?;
    var height: String?;
    var classify: String?;
    var attribute: String?;
    var des: String?;
    var like: Bool? = false
    
    
    func getInsertQuery () -> String {
        let _no = no ?? -1
        let _pokeNo = pokeNo ?? -1
        guard let _pokeName = pokeName else {fatalError()}
        guard let _imgSrc = imgSrc  else { fatalError() }
       return "INSERT INTO Poke (no, pokeNo, pokeName, imgSrc, like) Values ( \(_no), \(_pokeNo), '\(_pokeName)', '\(_imgSrc)', false)"
    }
    
    func getUpdateQuery () -> String {
        guard let _no = no else {fatalError()}
        guard let _weight = weight else {fatalError()}
        guard let _height = height else {fatalError()}
        guard let _classify = classify else {fatalError()}
        guard let _attribute = attribute else {fatalError()}
        guard let _des = des else {fatalError()}
        
        
        return "UPDATE Poke SET weight = '\(_weight)', height = '\(_height)', classify = '\(_classify)', attribute = '\(_attribute)', des = '\(_des)' WHERE no == \(_no)"
    }
}

