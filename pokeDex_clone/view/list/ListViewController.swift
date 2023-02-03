//
//  ListViewController.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/02/01.
//

import UIKit

class ListViewController: UIViewController {
    var listViewModel: ListViewModel
    var searchText: String = ""
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    init(listViewModel: ListViewModel) {
        self.listViewModel = listViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()

        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        
        drawNavBar()
        if let data = listViewModel.collectionData, data.count > 0 {
            drawCollectionView()
        } else {
            drawEmptyView()
        }
        
       
        
    }
    func drawNavBar(){
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor(named: "AccentColor")
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.topItem?.title = "검색 결과"
    }
    
    
    func drawCollectionView() {
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout() 
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    func drawEmptyView() {
        let emptyView = UIView()
        let emptyImageView = UIImageView(image: UIImage(named: "notresult"))
        let emptyLabel = UILabel()
        emptyLabel.text = "포켓몬이 없습니다."
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
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
        }
        
    }
}




extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(#function)
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(#function)
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let custom = cell as? ListCollectionViewCell else {return cell}
        guard let item = listViewModel.collectionData else {return cell}
        let itemPiece = item[indexPath.row]
        custom.pokeNumberLabel.text = itemPiece.pokeName
        return custom
    }
    
    
    
}
