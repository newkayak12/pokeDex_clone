//
//  DetailViewController.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/02/05.
//

import UIKit

class DetailViewController: UIViewController {
    let stackContainer =  UIStackView(frame: .zero)
    let imageView = UIImageView(frame: .zero)
    let stackNoNameIsFav = UIStackView(frame: .zero)
    let stackWeightHeightClass = UIStackView(frame: .zero)
    let stackType = UIStackView(frame: .zero)
    let descTextView = UITextView(frame: .zero)
    var imgView = UIImageView(image: UIImage(systemName: "heart",withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: CGFloat(20.0)))))
    
    var detailViewModel: DetailViewModel
    var data: PokeEntity
    
   
    
    /**
     pokeNo
     pokeName
     imgSrc
     weight
     height
     classify
     attribute
     des
     like
     */

    init(data: PokeEntity, detailViewModel: DetailViewModel) {
        self.data = data
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawNavBar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setData()
        setType()

        // Do any additional setup after loading the view.
    }
    
    func setupUI( ){
        data.println()
        stackContainer.axis = .vertical
        stackContainer.addSubview(imageView)
        drawImageView()
        
        stackContainer.addSubview(stackNoNameIsFav)
        drawNoNameIsFaveView()
        
        stackContainer.addSubview(stackWeightHeightClass)
        drawWeightHeightClass()
        
        stackContainer.addSubview(stackType)
        drawStackType()
        
        stackContainer.addSubview(descTextView)
        drawDescTextView()
//
//
//
        view.addSubview(stackContainer)
        stackContainer.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.bottom.equalTo(view.layoutMarginsGuide)
        }
    }
    func drawImageView() {
        imageView.image = UIImage(named: "skeleton")
        imageView.contentMode = .scaleAspectFit
        let width = view.bounds.width * 0.8
        imageView.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(width)
            make.centerX.equalTo(stackContainer)
            make.top.equalTo(stackContainer).offset(20)
        }
        
        print("ss")
    }
    func drawNoNameIsFaveView() {
        let width = view.bounds.width * 0.8
        stackNoNameIsFav.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        stackNoNameIsFav.axis = .horizontal
        stackNoNameIsFav.spacing = 10
        stackNoNameIsFav.distribution = .fillEqually
        stackNoNameIsFav.backgroundColor = .systemGroupedBackground
        let noLabel = UILabel(frame: .zero)
        noLabel.text =  "No. \(data.pokeNo ?? 000)"
        let nameLabel = UILabel(frame: .zero)
        nameLabel.text = data.pokeName ?? "Poké"
        let isFavView = UIButton(frame: .zero)
        isFavView.addTarget(self, action: #selector(changeLikeStatus), for: .touchUpInside)
        
        if let like = data.like {
            imgView = UIImageView(image: UIImage(systemName: like ? "heart.fill" : "heart",withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: CGFloat(20.0)))))
        }
        
        
        
        imgView.contentMode = .scaleAspectFit
        isFavView.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackNoNameIsFav.addSubview(noLabel)
        noLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(stackNoNameIsFav)
        }
        stackNoNameIsFav.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(stackNoNameIsFav)
        }
        stackContainer.addSubview(isFavView)
        isFavView.snp.makeConstraints { make in
//            make.trailing.equalTo(stackNoNameIsFav).offset(-25)
            make.centerX.equalTo(stackNoNameIsFav).multipliedBy(1.5)
            make.centerY.equalTo(stackNoNameIsFav)
        }
        
        
    }
    func drawWeightHeightClass() {
        
        stackWeightHeightClass.axis = .horizontal
        stackWeightHeightClass.spacing = 10
        stackWeightHeightClass.distribution = .fillEqually
        let width = view.bounds.width * 0.8
        stackWeightHeightClass.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(40)
            make.top.equalTo(stackNoNameIsFav.snp.bottom)
            make.centerX.equalToSuperview()
        }
        let weightLabel = UILabel(frame: .zero)
        weightLabel.text = data.weight ?? "0.0kg"
        weightLabel.textAlignment = .center
        let heightLabel = UILabel(frame: .zero)
        heightLabel.text = data.height ?? "0.0m"
        heightLabel.textAlignment = .center
        let classLabel = UILabel(frame: .zero)
        classLabel.text = data.classify ?? "Poké"
        classLabel.textAlignment = .center
        
        stackWeightHeightClass.addSubview(weightLabel)
        weightLabel.snp.makeConstraints { make in
            make.leading.equalTo(stackWeightHeightClass).offset(20)
            make.centerY.equalToSuperview()
        }
        
        stackWeightHeightClass.addSubview(heightLabel)
        heightLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        stackWeightHeightClass.addSubview(classLabel)
        classLabel.snp.makeConstraints { make in
            make.trailing.equalTo(stackWeightHeightClass).offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    func drawStackType() {
        let width = view.bounds.width * 0.8
        stackType.distribution = .fillEqually
        stackType.backgroundColor = .systemGroupedBackground
        stackType.spacing = 10
        stackType.isLayoutMarginsRelativeArrangement = true
        stackType.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        stackType.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(stackWeightHeightClass.snp.bottom)
        }
    }
    
    func drawDescTextView() {
        descTextView.text = data.des ?? "DESCRIPTION"
        descTextView.isEditable = false
        descTextView.font = .preferredFont(forTextStyle: .body)
        descTextView.textAlignment = .justified
        descTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let width = view.bounds.width * 0.8
        descTextView.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.centerX.equalToSuperview()
            make.top.equalTo(stackType.snp.bottom).offset(10)
            make.bottom.equalTo(stackContainer)
        }
    }
    
    func setData() {
        guard let urlString = data.imgSrc else {return}
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    if let result = data{
                        self!.imageView.image = UIImage(data: result)
                    }
                }
            }
        }.resume()
    }
    func setType() {
        guard let type = data.type else {return}
        type.forEach{
            let label = UILabel(frame: .zero)
            label.textAlignment = .center
            label.layer.cornerRadius = 10
            label.layer.borderColor = UIColor.black.cgColor
            label.layer.borderWidth = 0.1
            label.clipsToBounds = true
            label.text = $0.type
            if let value = $0.type {
                label.textColor = .white
                label.backgroundColor = ColorSet.pick(type: value)
            }
            
            stackType.addArrangedSubview(label)
        }
    }
    
    func drawNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
//        navigationController?.navigationBar.topItem?.title = "no. \(data.pokeNo) \(data.pokeName)"
        navigationItem.title = data.pokeName!
    }
    
    @objc func changeLikeStatus() {
        guard let like = data.like else { return }
        let text = like ? "좋아요를 해제하시겠습니까?" : "좋아요 하시겠습니까?"
        let alert = UIAlertController(title: "좋아요", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] action in
            self!.changeAction()
        }))
        present(alert, animated: true)
    }
    
    func changeAction() {
        if let like =  data.like, like != detailViewModel.changeLikeStatus(poke: data){
            print(like)
            imgView.image = UIImage(systemName: !like ? "heart.fill" : "heart",withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: CGFloat(20.0))))
            self.loadViewIfNeeded()
        }
    }
    
}
