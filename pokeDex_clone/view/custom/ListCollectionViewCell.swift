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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
