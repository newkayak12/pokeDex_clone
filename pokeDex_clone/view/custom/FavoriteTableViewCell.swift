//
//  FavoriteTableViewCell.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/02/01.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    var pokeImg = UIImageView()
    var pokeLabel = UILabel()
    var likeImg = UIImageView()
    var isLike = true
    
    let like = "heart.fill"
    let unlike = "heart"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        draw()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func draw() {
        self.addSubview(pokeImg)
        self.addSubview(pokeLabel)
        
        likeImg.image = UIImage(named: isLike ? like : unlike)
        self.accessoryView = likeImg
        self.editingAccessoryView = likeImg
        
        pokeImg.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(100)
        }
        pokeLabel.snp.makeConstraints { make in
            make.leading.equalTo(pokeImg.snp.trailing).offset(30)
            make.centerY.equalTo(self.snp.centerY)
        }
    }

}