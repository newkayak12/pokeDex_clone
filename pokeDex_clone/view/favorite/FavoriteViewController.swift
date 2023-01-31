//
//  FavoriteViewController.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/29.
//

import UIKit

class FavoriteViewController: UIViewController {
    let tableView = UITableView(frame: .zero)
    var favoriteViewModel: FavoriteViewModel?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        drawNav()
        favoriteViewModel = FavoriteViewModel()
        favoriteViewModel!.fetchData()
        
        if let data = favoriteViewModel!.tableData, data.count > 0 {
            drawTableView()
        } else {
            drawEmptyView()
        }
        
        
        
        
       
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
    func drawEmptyView() {
        let emptyView = UIView()
        let emptyImageView = UIImageView(image: UIImage(named: "notresult"))
        let emptyLabel = UILabel()
        emptyLabel.text = "좋아요한 포켓몬이 없습니다."
        emptyLabel.font = UIFont(name: emptyLabel.font.fontName, size: CGFloat(20))
        emptyView.addSubview(emptyImageView)
        emptyView.addSubview(emptyLabel)
        emptyImageView.snp.makeConstraints { make in
            make.centerX.equalTo(emptyView.snp.centerX)
            make.centerY.equalTo(emptyView.snp.centerY).multipliedBy(0.5)
        }
        emptyLabel.textAlignment = .center
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(emptyView.snp.centerX)
            make.top.equalTo(emptyImageView.snp.bottom)
        }
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
        
    }
    func drawTableView() {
        tableView.dataSource = favoriteViewModel
        tableView.delegate = favoriteViewModel
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        ////        tableView.rowHeight = UITableView.automaticDimension
        ////        tableView.estimatedRowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
   

}

