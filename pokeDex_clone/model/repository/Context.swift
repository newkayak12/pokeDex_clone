//
//  DB.swift
//  pokéDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/28.
//

import Foundation
import SQLite3
class Context {
    static let shared = Context()
    var db: OpaquePointer?
    let schemaName:String =  "poke.sqlite"
    static let url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("poke.sqlite")
    
    init(){
        
//        var absoluteUrl = ""
//
//        do {
//
//            absoluteUrl = try FileManager.default.url( for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(schemaName).path
//        } catch {
//            print(error)
//        }
//
//        print("EXIST \(FileManager.default.fileExists(atPath: absoluteUrl))")
//        if( !FileManager.default.fileExists(atPath: absoluteUrl) ){
            self.db = createSchema()
//        }
    }
    deinit {
        sqlite3_close(db)
    }
    
    func createSchema() -> OpaquePointer?{
        var db: OpaquePointer? = nil
        do {
            let dbPath: String = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false).appendingPathComponent(schemaName).path
            
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
                print("Successfully created DB. Path: \(dbPath)")
                return db
            }
        } catch {
            print("Error while creating Database -\(error.localizedDescription)")
        }
        return nil
    }
}

