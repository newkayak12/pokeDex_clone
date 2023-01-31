//
//  Type+Image.swift
//  pokéDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/28.
//

import Foundation
class TypeImageEntity: Codable {
    var type: String?;
    var imgSrc: String?;
    
    func println() {
        print("\(type), \(imgSrc)")
    }
    
    func getInsertQuery() -> String {
        guard let _type = type else {fatalError()}
        guard let _imgSrc = imgSrc  else {fatalError()}
        
        return "INSERT INTO TypeImage (typeName, imgSrc) VALUES ('\(_type)', '\(_imgSrc)')"
    }
}
