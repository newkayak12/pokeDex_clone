//
//  Type.swift
//  pokéDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/28.
//

import Foundation
class TypeEntity: Codable {
    var no: Int?;
    var pokeNo: Int?;
    var background: String?;
    var fontColor: String?;
    var typeName: String?;
    
    

    func getInsertQuery() -> String {
        
        guard let _no = no else {fatalError()}
        guard let _pokeNo = pokeNo else {fatalError()}
        guard let _background = background else {fatalError()}
        guard let _fontColor = fontColor else {fatalError()}
        if let _typeName = typeName  {
            return "INSERT INTO Type ( pokeNo, background, fontColor, typeName) Values ( \(_no), \(_pokeNo), '\(_background)', '\(_fontColor)', '\(_typeName)')"
        }
        
        return "INSERT INTO Type (no, pokeNo, background, fontColor) Values ( \(_no), \(_pokeNo), '\(_background)', '\(_fontColor)')"
    }
    
}
