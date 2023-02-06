//
//  NavigationViewController.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/28.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let homeImage = UIImage(systemName: "house.fill", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large))
        let favImage = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large))
        let main = NavigationViewController(rootViewController: MainViewController())
        main.tabBarItem.title = "Home"
        main.tabBarItem.image = homeImage
        
       
        let fav = NavigationViewController(rootViewController: FavoriteViewController(favoriteViewModel: FavoriteViewModel(reposit: PokeRepository())))
        fav.tabBarItem.title = "Favorite"
        fav.tabBarItem.image = favImage
        fav.navigationBar.overrideUserInterfaceStyle = .dark
        viewControllers = [main, fav]
        tabBar.backgroundColor = .systemGroupedBackground
    }

}
