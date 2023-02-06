//
//  PokeRepository.swift
//  pokéDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/28.
//

import Foundation
import SQLite3
class PokeRepository {
    var db = Context.shared.db
    
    
    func createTable() throws {
        let fileURL = Context.url
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("table not exsist")
        }
        
        let CREATE_QUERY_TEXT : String = """
                                        CREATE TABLE IF NOT EXISTS Poke (
                                            no INTEGER PRIMARY KEY AUTOINCREMENT,
                                            pokeNo INTEGER,
                                            pokeName TEXT,
                                            imgSrc TEXT,
                                            weight TEXT,
                                            height TEXT,
                                            classify TEXT,
                                            attribute TEXT,
                                            des TEXT,
                                            like INTEGER
                                        )
                                        """
        
        print(CREATE_QUERY_TEXT)
        if sqlite3_exec(db, CREATE_QUERY_TEXT, nil, nil, nil) != SQLITE_OK {
            let errMsg = String(cString:sqlite3_errmsg(db))
            print("db table create error : \(errMsg)")
        }
    }
    
    func insert(poke: PokeEntity) throws {
        var stmt: OpaquePointer?
        
        
        
        let INSERT_QUERY_TEXT : String = poke.getInsertQuery();
//        print(INSERT_QUERY_TEXT)
        
        if sqlite3_prepare(db, INSERT_QUERY_TEXT, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert:v1 \(errMsg)")
            return
        }
        
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errMsg = String(cString : sqlite3_errmsg(db)!)
            print("insert fail :: \(errMsg)")
            do {
                try insert(poke: poke)
            } catch {
                print(error)
            }
            return
        }
        
    }
    
    func update(poke: PokeEntity) {
        let UPDATE_QUERY = poke.getUpdateQuery()
//        print(UPDATE_QUERY)
        
        var stmt:OpaquePointer?
        if sqlite3_prepare(db, UPDATE_QUERY, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing update: v1\(errMsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errMsg = String(cString : sqlite3_errmsg(db)!)
            print("update fail :: \(errMsg)")
            return
        }
        
        sqlite3_finalize(stmt)
    }
    
    func changeLike(poke: PokeEntity)  -> Int {
        
        let UPDATE_QUERY = poke.getUpdateFavoriteStatus(no: poke.no!, value: !poke.like!)
        //        print(UPDATE_QUERY)
        
        var stmt:OpaquePointer?
        if sqlite3_prepare(db, UPDATE_QUERY, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing update: v1\(errMsg)")
            return 0
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errMsg = String(cString : sqlite3_errmsg(db)!)
            print("update fail :: \(errMsg)")
            return 0
        }
        
        sqlite3_finalize(stmt)
        return 1
    }
    
    func selectWhereFavorite () -> [PokeEntity] {
        var pokeList: [PokeEntity] = []
        var typeList: [TypeEntity] = []
    
        let SELECT_QUERY = PokeEntity().getSelectWhereFavorite()
        var stmt:OpaquePointer?
        
        
        if sqlite3_prepare(db, SELECT_QUERY, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: v1\(errMsg)")
            return pokeList
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            
            let no = sqlite3_column_int(stmt, 0)
            let pokeNo = sqlite3_column_int(stmt, 1)
            let pokeName = String(cString: sqlite3_column_text(stmt, 2))
            let imgSrc = String(cString: sqlite3_column_text(stmt, 3))
            let weight = String(cString: sqlite3_column_text(stmt, 4))
            let height = String(cString: sqlite3_column_text(stmt, 5))
            let classify = String(cString: sqlite3_column_text(stmt, 6))
            let attribute = String(cString: sqlite3_column_text(stmt, 7))
            let des = String(cString: sqlite3_column_text(stmt, 8))
            let like = sqlite3_column_int(stmt, 9) == 1 ? true : false
            
            let typeNo = Int(sqlite3_column_int(stmt, 10))
            let typePokeNo = Int(sqlite3_column_int(stmt, 11))
            let background = String(cString: sqlite3_column_text(stmt, 12))
            let fontColor = String(cString: sqlite3_column_text(stmt, 13))
            let type = String(cString: sqlite3_column_text(stmt, 14))
            
            let poke = PokeEntity()
            let typeEntity = TypeEntity()
            
            
            poke.no = Int(no)
            poke.pokeNo = Int(pokeNo)
            poke.pokeName = pokeName
            poke.imgSrc = imgSrc
            poke.weight = weight
            poke.height = height
            poke.classify = classify
            poke.attribute = attribute
            poke.des = des
            poke.like = like
            
            typeEntity.no = typeNo
            typeEntity.pokeNo = typePokeNo
            typeEntity.background = background
            typeEntity.fontColor = fontColor
            typeEntity.type = type
            
            pokeList.append(poke)
            typeList.append(typeEntity)
        }
        
        let pok = pokeList.unique { $0.no }
        pok.forEach { pokEntity in
            pokEntity.println()
            pokEntity.type = typeList.filter {$0.no == pokEntity.no}
        }
        
        
        
        return pok
    }
    
    func selectAll () -> [PokeEntity] {
        print(#function)
        var pokeList: [PokeEntity] = []
        var typeList: [TypeEntity] = []
        
        let SELECT_QUERY = PokeEntity().getSelectAll()
        var stmt:OpaquePointer?
        
        
        if sqlite3_prepare(db, SELECT_QUERY, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: v1\(errMsg)")
            return pokeList
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            
            let no = sqlite3_column_int(stmt, 0)
            let pokeNo = sqlite3_column_int(stmt, 1)
            let pokeName = String(cString: sqlite3_column_text(stmt, 2))
            let imgSrc = String(cString: sqlite3_column_text(stmt, 3))
            let weight = String(cString: sqlite3_column_text(stmt, 4))
            let height = String(cString: sqlite3_column_text(stmt, 5))
            let classify = String(cString: sqlite3_column_text(stmt, 6))
            let attribute = String(cString: sqlite3_column_text(stmt, 7))
            let des = String(cString: sqlite3_column_text(stmt, 8))
            let like = sqlite3_column_int(stmt, 9) == 1 ? true : false
            
           
            let typeNo = Int(sqlite3_column_int(stmt, 10))
            let typePokeNo = Int(sqlite3_column_int(stmt, 11))
            let background = String(cString: sqlite3_column_text(stmt, 12))
            let fontColor = String(cString: sqlite3_column_text(stmt, 13))
            var type = ""
            if let t = sqlite3_column_text(stmt, 14) {
                 type = String(cString: t)
            }
            
            
            let poke = PokeEntity()
            let typeEntity = TypeEntity()
            
            
            poke.no = Int(no)
            poke.pokeNo = Int(pokeNo)
            poke.pokeName = pokeName
            poke.imgSrc = imgSrc
            poke.weight = weight
            poke.height = height
            poke.classify = classify
            poke.attribute = attribute
            poke.des = des
            poke.like = like
            
            typeEntity.no = typeNo
            typeEntity.pokeNo = typePokeNo
            typeEntity.background = background
            typeEntity.fontColor = fontColor
            typeEntity.type = type
            
            
            pokeList.append(poke)
            typeList.append(typeEntity)
            
//            poke.println()
        }
        
        let pok = pokeList.unique { $0.no }
        pok.forEach { pokEntity in
            pokEntity.type = typeList.filter {$0.no == pokEntity.no}
        }
        
        return pok
    }
    
    
    
    func selectWhereName (searchText: String) -> [PokeEntity] {
        print(#function)
        var pokeList: [PokeEntity] = []
        var typeList: [TypeEntity] = []
        
        let SELECT_QUERY = PokeEntity().getSelectWhereName(name: searchText)
        var stmt:OpaquePointer?
        
        
        if sqlite3_prepare(db, SELECT_QUERY, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: v1\(errMsg)")
            return pokeList
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            
            let no = sqlite3_column_int(stmt, 0)
            let pokeNo = sqlite3_column_int(stmt, 1)
            let pokeName = String(cString: sqlite3_column_text(stmt, 2))
            let imgSrc = String(cString: sqlite3_column_text(stmt, 3))
            let weight = String(cString: sqlite3_column_text(stmt, 4))
            let height = String(cString: sqlite3_column_text(stmt, 5))
            let classify = String(cString: sqlite3_column_text(stmt, 6))
            let attribute = String(cString: sqlite3_column_text(stmt, 7))
            let des = String(cString: sqlite3_column_text(stmt, 8))
            let like = sqlite3_column_int(stmt, 9) == 1 ? true : false
            
            let typeNo = Int(sqlite3_column_int(stmt, 10))
            let typePokeNo = Int(sqlite3_column_int(stmt, 11))
            let background = String(cString: sqlite3_column_text(stmt, 12))
            let fontColor = String(cString: sqlite3_column_text(stmt, 13))
            let type = String(cString: sqlite3_column_text(stmt, 14))
            
            let poke = PokeEntity()
            let typeEntity = TypeEntity()
            
            
            poke.no = Int(no)
            poke.pokeNo = Int(pokeNo)
            poke.pokeName = pokeName
            poke.imgSrc = imgSrc
            poke.weight = weight
            poke.height = height
            poke.classify = classify
            poke.attribute = attribute
            poke.des = des
            poke.like = like
            
            typeEntity.no = typeNo
            typeEntity.pokeNo = typePokeNo
            typeEntity.background = background
            typeEntity.fontColor = fontColor
            typeEntity.type = type
            
            pokeList.append(poke)
            typeList.append(typeEntity)
            
            //            poke.println()
        }
        
        
        let pok = pokeList.unique { $0.no }
        pok.forEach { pokEntity in
            pokEntity.type = typeList.filter {
                print("TYPE NO \($0.no) : POKE NO \(pokEntity.no)")
                return $0.no == pokEntity.no
            }
        }
        
        return pok
    }
}

extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
    
    
}
