//
//  TypeRepository.swift
//  pokéDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/28.
//

import Foundation
import SQLite3
class TypeRepository {
    var db = Context.shared.db
    
    func createTable() throws {
        let fileURL = Context.url
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("table not exsist")
        }
        
        let CREATE_QUERY_TEXT : String = """
                                        CREATE TABLE IF NOT EXISTS Type (
                                            no INTEGER,
                                            pokeNo INTEGER,
                                            background TEXT,
                                            fontColor TEXT,
                                            typeName TEXT
                                        )
                                        """
        
        print(CREATE_QUERY_TEXT)
        if sqlite3_exec(db, CREATE_QUERY_TEXT, nil, nil, nil) != SQLITE_OK {
            let errMsg = String(cString:sqlite3_errmsg(db))
            print("db table create error : \(errMsg)")
        }
    }
    
    func insert(type: TypeEntity) {
        var stmt: OpaquePointer?
        
        
        
        let INSERT_QUERY_TEXT : String = type.getInsertQuery();
        
        if sqlite3_prepare(db, INSERT_QUERY_TEXT, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert:v1 \(INSERT_QUERY_TEXT)")
            return
        }
        
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errMsg = String(cString : sqlite3_errmsg(db)!)
            print("insert fail :: \(errMsg)")
            return
        }
        
    }
    
}
