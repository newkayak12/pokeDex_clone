//
//  ListCollectionViewCell.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/02/02.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    var image = UIImageView(frame: .zero)
    var pokeNumberLabel = UILabel(frame: .zero)
    var pokeName = UILabel(frame: .zero)
    var typeView = UIView(frame: .zero)
    var stackView: UIStackView = UIStackView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = UIImage(named: "skeleton")
        stackView.removeFromSuperview()
        
    }
    
    func drawUI() {
        image.image = UIImage(named: "skeleton")
        self.addSubview(image)
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = CGFloat(0.2)
        self.layer.cornerRadius = 20
      
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
//            make.width.equalTo(100)
            make.height.equalTo(image.snp.width)
        }
        self.addSubview(pokeNumberLabel)
        pokeNumberLabel.textColor = .systemGray
        pokeNumberLabel.font = UIFont(name: pokeNumberLabel.font.fontName, size: 13.0)
        pokeNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom)
            make.leading.equalTo(image)
        }
        self.addSubview(pokeName)
        pokeName.snp.makeConstraints { make in
            make.top.equalTo(pokeNumberLabel.snp.bottom)
            make.leading.equalTo(image)
        }
        
        self.addSubview(typeView)
        typeView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
            make.top.equalTo(pokeName.snp.bottom).offset(10)
        }
    }
    
    func drawStackView (typeEntity: [TypeEntity]?) {
        guard let type = typeEntity else {return}
        let views = type.map {
            let label = UILabel(frame: .zero)
            label.text = $0.type
            label.textAlignment = .center
            label.layer.borderWidth = 0.1
            label.layer.borderColor = UIColor.black.cgColor
            
            if let value = $0.type {
                label.textColor = .white
                label.backgroundColor = ColorSet.pick(type: value)
            }
            label.clipsToBounds = true
            label.layer.cornerRadius = 10
            
            
            return label
        }
         stackView = UIStackView(arrangedSubviews: views)
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        typeView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setImage(data: Data){
        image.image = UIImage(data: data)
    }
    
}
