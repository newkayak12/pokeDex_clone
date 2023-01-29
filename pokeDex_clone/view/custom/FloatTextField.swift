//
//  FloatTextField.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/29.
//

import UIKit
import SnapKit

class FloatTextField {
    var container: UIView
    var placeholderText: UILabel
    var textfield: UITextField
    var placeholder: String = ""
    init(placeholder: String) {
        self.container = UIView(frame: .zero)
        self.placeholderText = UILabel()
        self.textfield = UITextField(frame: .zero)
        container.backgroundColor = .clear
        self.placeholder = placeholder
        self.placeholderText.text = placeholder
        self.placeholderText.font.pointSize = CGFloat(5)
        self.textfield.placeholder = placeholder
        
        container.addSubview(textfield)
        container.addSubview(placeholderText)
        container.translatesAutoresizingMaskIntoConstraints = false
        placeholderText.translatesAutoresizingMaskIntoConstraints = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        container.snp.makeConstraints { make in
            make.top.equalTo(textfield.snp.top).offset(-20)
            make.leading.equalTo(textfield.snp.leading)
            make.trailing.equalTo(textfield.snp.trailing)
            make.bottom.equalTo(textfield.snp.bottom)
        }
        
        placeholderText.snp.makeConstraints { make in
            make.top.equalTo(container.snp.top)
            make.leading.equalTo( container.snp.leading).offset(10)
        }
        
        
    }
   
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
