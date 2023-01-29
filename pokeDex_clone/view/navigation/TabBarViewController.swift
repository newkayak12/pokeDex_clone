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
        
        let fav = FavoriteViewController()
        fav.tabBarItem.title = "Favorite"
        fav.tabBarItem.image = favImage
        viewControllers = [main, fav]
        tabBar.backgroundColor = .systemGroupedBackground
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
