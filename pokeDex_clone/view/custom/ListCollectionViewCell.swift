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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawUI() {
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
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
            make.top.equalTo(pokeName.snp.bottom).offset(10)
        }
    }
    
}
