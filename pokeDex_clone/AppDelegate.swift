//
//  AppDelegate.swift
//  pokéDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initialize()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func initialize() {
        let isFirst =  UserDefaults.standard.bool(forKey: "isFirst")
        if(!isFirst){
//        if(true){
            
            
            let _ = Context.shared
            Thread.sleep(forTimeInterval: 0.5)
            dbInit()
            UserDefaults.standard.set(true, forKey: "isFirst")
        }
        
//        PokeRepository().selectAll()
        
        
    }

    func dbInit(){
        print("DBINIT1")
        let pokeListUrl = Bundle.main.url(forResource: "list", withExtension: "json")
        let pokeUpUrl = Bundle.main.url(forResource: "pokeUp", withExtension: "json")
        let typeUrl = Bundle.main.url(forResource: "type", withExtension: "json")
        let typeImageUrl = Bundle.main.url(forResource: "typeImge", withExtension: "json")
        let decoder = JSONDecoder()
        
        do {
            let pokeRepository = PokeRepository()
            let typeRepository = TypeRepository()
            let typeImageRepository = TypeImageRepository()
            
            try pokeRepository.createTable()
            try typeRepository.createTable()
            try typeImageRepository.createTable()
            
            Thread.sleep(forTimeInterval: 0.5)
            
            
            if let url = pokeListUrl {
                print("list")
                let json = try Data(contentsOf: url)
                let parseValue = try decoder.decode([PokeEntity].self, from: json)
                try parseValue.forEach { poke in
//                    poke.println()
                    try pokeRepository.insert(poke: poke)
                }
            }
            
            if let url = pokeUpUrl {
                print("list-up")
                let json = try Data(contentsOf: url)
                let parseValue = try decoder.decode([PokeEntity].self, from: json)
                
                Thread.sleep(forTimeInterval: 0.5)
                
                parseValue.forEach({ poke in
//                    poke.println()
                    pokeRepository.update(poke: poke)
                })
            }
            
            
            if let url = typeUrl {
                print("type")
                let json = try Data(contentsOf: url)
                let parseValue = try decoder.decode([TypeEntity].self, from: json)
                parseValue.forEach({ type in
//                    type.println()
                    typeRepository.insert(type: type)
                })
                
                
            }
            
            if let url = typeImageUrl {
                print("type-img")
                let json = try Data(contentsOf: url)
                let parseValue = try decoder.decode([TypeImageEntity].self, from: json)
                parseValue.forEach({ typeImg in
//                    typeImg.println()
                    typeImageRepository.insert(typeImage: typeImg)
                })
            }
            
            
        } catch {
            print(error)
        }
    }

}

