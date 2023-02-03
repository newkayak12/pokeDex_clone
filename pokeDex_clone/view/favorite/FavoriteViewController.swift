//
//  FavoriteViewController.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/29.
//

import UIKit

class FavoriteViewController: UIViewController {
    let tableView = UITableView(frame: .zero)
    var favoriteViewModel: FavoriteViewModel
    
    init(favoriteViewModel: FavoriteViewModel) {
        self.favoriteViewModel = favoriteViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        drawNav()
        
        if let data = favoriteViewModel.tableData, data.count > 0 {
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
            make.centerX.equalTo(emptyView)
            make.centerY.equalTo(emptyView).multipliedBy(0.5)
        }
        emptyLabel.textAlignment = .center
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(emptyView)
            make.top.equalTo(emptyImageView.snp.bottom)
        }
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    func drawTableView() {
        tableView.dataSource = favoriteViewModel
        tableView.delegate = favoriteViewModel
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "cell")
        ////        tableView.rowHeight = UITableView.automaticDimension
        ////        tableView.estimatedRowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
   

}

