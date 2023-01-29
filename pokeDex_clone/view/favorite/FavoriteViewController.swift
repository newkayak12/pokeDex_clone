//
//  FavoriteViewController.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/29.
//

import UIKit

class FavoriteViewController: UIViewController {
    let tableView = UITableView(frame: .zero, style: .plain)
    let tableCell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        drawNav()
        
        
        // Do any additional setup after loading the view.
    }
    
    func drawNav () {
        let nav = UINavigationBar(frame: .zero)
        nav.barTintColor = UIColor(named: "AccentColor")
        nav.prefersLargeTitles = false
        nav.isTranslucent = true
        nav.tintColor = UIColor(named: "AccentColor")
        let titleItem = UINavigationItem(title: "좋아하는 포켓몬")
        titleItem.scrollEdgeAppearance?.backgroundColor = UIColor(named: "AccentColor")
        titleItem.titleView?.tintColor = UIColor(named: "AccentColor")
        nav.items = [ titleItem]
        
        let dummyView = UIView(frame: .zero)
        dummyView.backgroundColor = UIColor(named: "AccentColor")
        
        view.addSubview(dummyView)
        dummyView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        view.addSubview(nav)
        nav.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            
        }
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
