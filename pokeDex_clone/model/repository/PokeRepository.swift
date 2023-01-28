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
        
        if sqlite3_prepare(db, INSERT_QUERY_TEXT, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert:v1 \(errMsg)")
            return
        }
        
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
//        if sqlite3_bind_text(stmt, 1, title, -1, SQLITE_TRANSIENT) != SQLITE_OK{
//            let errMsg = String(cString : sqlite3_errmsg(db)!)
//            print("failture binding name: \(errMsg)")
//            return
//        }
//
//        if sqlite3_bind_text(stmt, 2, subline, -1, SQLITE_TRANSIENT) != SQLITE_OK{
//            let errMsg = String(cString : sqlite3_errmsg(db)!)
//            print("failture binding name: \(errMsg)")
//            return
//        }
//
//
//        if sqlite3_bind_text(stmt, 3, date, -1, SQLITE_TRANSIENT) != SQLITE_OK{
//            let errMsg = String(cString : sqlite3_errmsg(db)!)
//            print("failture binding name: \(errMsg)")
//            return
//        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errMsg = String(cString : sqlite3_errmsg(db)!)
            print("insert fail :: \(errMsg)")
            return
        }
        
    }
    
    func update(poke: PokeEntity) {
        let UPDATE_QUERY = poke.getUpdateQuery()
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
}
