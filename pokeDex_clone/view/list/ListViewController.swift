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
    let collectionViewInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    let minimumSpaceBetweenItemHorizontally = CGFloat(20)
    let minimumSpaceBetweenItemVertically = CGFloat(20)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    init(listViewModel: ListViewModel) {
        self.listViewModel = listViewModel
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
        let backbutton = UIButton(type: .custom)
        
        
        backbutton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(.white, for: .normal)
        backbutton.tintColor = .white
        backbutton.addTarget(self, action: #selector(backward), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        
        
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
    
    @objc func backward() {
       dismiss(animated: true)
    }
}




extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpaceBetweenItemVertically
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpaceBetweenItemHorizontally
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionViewInset
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(#function)
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(#function)
        let size = ( view.bounds.width - ( (collectionViewInset.left + collectionViewInset.right) + minimumSpaceBetweenItemHorizontally) ) / 2
        return CGSize(width: size.rounded(.down), height: size.rounded(.down) * 1.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        guard let list = listViewModel.collectionData else { return 0}
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let custom = cell as? ListCollectionViewCell else {return cell}
        
        guard let item = listViewModel.collectionData else {return cell}
        let itemPiece = item[indexPath.row]
        custom.pokeNumberLabel.text = "no. \(itemPiece.pokeNo!)"
        custom.pokeName.text = itemPiece.pokeName
        
        print(itemPiece.pokeName)
        itemPiece.type?.forEach{print($0.type)}
        
        
        let url = URL(string: itemPiece.imgSrc!)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    if let result = data{
                        custom.image.image = UIImage(data: result)
                    }
                }
            }
        }.resume()
        
        custom.backgroundColor = .systemBackground
        
        let container = UIStackView(frame: .zero)
        container.axis = .horizontal
      
        container.distribution = .equalSpacing
        container.alignment = .fill
        
        custom.typeView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        container.layoutIfNeeded()
        let containerWidth = container.layer.frame.width
        let containerPerCountWidth = ((containerWidth / 10).rounded(.down) * 10) / CGFloat(itemPiece.type?.count ?? 1)
        let insets = containerWidth - (containerWidth / 10).rounded(.down) * 10
        container.spacing = CGFloat(3)
        var count = 0
        itemPiece.type?.forEach{
            let label = UILabel(frame: .zero)
            label.text = $0.type
            label.layer.borderColor = UIColor.lightGray.cgColor
            label.layer.borderWidth = 0.1
            label.layer.cornerRadius = 5
            label.clipsToBounds = true
            if let value = $0.type {
                label.backgroundColor = ColorSet.pick(type: value)
            }
            label.textAlignment = .center
            container.addSubview(label)
            label.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                print(containerPerCountWidth)
                print(CGFloat(insets / CGFloat((count + 2))) + CGFloat(containerPerCountWidth * CGFloat(count)))
                make.leading.equalToSuperview().offset(CGFloat(3 * (count + 1)) + CGFloat(containerPerCountWidth * CGFloat(count)))
                make.width.equalTo(containerPerCountWidth)
            }
            count += 1
        }
        return custom
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let data = listViewModel.collectionData else {return}
        let selectedData = data[indexPath.row]
        
        let detailViewController = DetailViewController(data: selectedData, detailViewModel: DetailViewModel())
        detailViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

extension UIColor {
    convenience init(rgbHex: Int) {
        
        self.init(
            red: CGFloat((rgbHex >> 16) & 0xFF),
            green: CGFloat((rgbHex >> 8) & 0xFF),
            blue: CGFloat(rgbHex & 0xFF),
            alpha: CGFloat(1.0)
        )
    }
}
