//
//  FavoriteViewController.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/29.
//

import UIKit

class FavoriteViewController: UIViewController {
    let tableView = UITableView(frame: .zero)
    var tableData: [PokeEntity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        drawNav()
        setNeedsStatusBarAppearanceUpdate()
        
//
        tableView.dataSource = self
        tableView.delegate = self

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
////        tableView.rowHeight = UITableView.automaticDimension
////        tableView.estimatedRowHeight = UITableView.automaticDimension
       
            let emptyView = UIView()
            let emptyImageView = UIImageView(image: UIImage(named: "notresult"))
            let emptyLabel = UILabel()
            emptyLabel.text = "좋아요한 포켓몬이 없습니다."
            emptyView.addSubview(emptyImageView)
            emptyView.addSubview(emptyLabel)
            emptyImageView.snp.makeConstraints { make in
                make.centerX.equalTo(emptyView.snp.centerX)
                make.centerY.equalTo(emptyView.snp.centerY)
                make.leading.equalTo(emptyView.snp.leading)
                make.trailing.equalTo(emptyView.snp.trailing)
                make.top.equalTo(emptyView.snp.top)
                make.bottom.equalTo(emptyView.snp.bottom)
            }
            emptyLabel.textAlignment = .center
            emptyLabel.snp.makeConstraints { make in
                make.top.equalTo(emptyView.snp.bottom)
            }
            
            tableView.addSubview(emptyView)
            emptyView.snp.makeConstraints { make in
                make.top.equalTo(tableView.snp.top)
                make.bottom.equalTo(tableView.snp.bottom)
                make.leading.equalTo(tableView.snp.leading)
                make.trailing.equalTo(tableView.snp.trailing)
            }
        
        if let _ = tableData {
            emptyView.isHidden = true
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
        tableView.reloadData()
//        
        // Do any additional setup after loading the view.
    }
    
    func drawNav () {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor(named: "AccentColor")
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.topItem?.title = "좋아하는 포켓몬"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        print("STATUS")
        return .lightContent
    }
   

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print(#function)
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        guard let tableData = tableData else {return 0}
//        return tableData.count
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "HI"
        cell.backgroundColor = .yellow
        return cell
    }
    
}
