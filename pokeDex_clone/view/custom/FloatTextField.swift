//
//  FloatTextField.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/29.
//

import UIKit
import SnapKit

protocol FloatTextFieldDelegate {
    func textFieldPressReturn ()
}

class FloatTextField: NSObject, UITextFieldDelegate {
    var delegate: FloatTextFieldDelegate?
    
    var container: UIView?
    var placeholderText: UILabel?
    var textfield: UITextField?
    var placeholder: String = ""
    
    override init(){
        
    }
    func initiate(placeholder: String){
       
        
        self.container = UIView(frame: .zero)
        self.placeholderText = UILabel()
        self.textfield = UITextField(frame: .zero)
        container!.backgroundColor = .clear
        self.placeholder = placeholder
        
        guard let placeholderText = self.placeholderText else {fatalError()}
        guard let textfield = self.textfield else {fatalError()}
        guard let container = self.container else {fatalError()}
        
        textfield.delegate = self
        textfield.returnKeyType = .search
//        textfield.enablesReturnKeyAutomatically = true
        
        
        placeholderText.text = "  "+placeholder+"  "
        placeholderText.font = UIFont(name: placeholderText.font.fontName, size: CGFloat(17))
        placeholderText.backgroundColor = .white
        placeholderText.textColor = UIColor.gray
        placeholderText.isHidden = true
        textfield.placeholder = placeholder
        
        textfield.addTarget(self, action: #selector(editStart), for: .editingDidBegin)
        textfield.addTarget(self, action: #selector(editEnd), for: .editingDidEnd)
        
        
        textfield.delegate = self
        
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
            make.centerY.equalTo(textfield.snp.centerY)
            make.leading.equalTo(textfield.snp.leading).offset(10)
            //            make.top.equalTo(textfield.snp.top).offset(-3)
            //            make.leading.equalTo( textfield.snp.leading).offset(20)
        }
    }
    
   
    @objc func editStart(){
        guard let textfield = self.textfield else {fatalError()}
        guard let placeholderText = self.placeholderText else {fatalError()}
        
        textfield.layer.borderColor = UIColor.red.cgColor
        UIView.animate(withDuration: 0.125) {
            let move = CGAffineTransform(scaleX:0.8, y: 0.8)
            let scale = CGAffineTransform(translationX: -30, y: -40)
            placeholderText.textColor = UIColor.red
            placeholderText.transform = move.concatenating(scale)
            placeholderText.isHidden = false
        }
        textfield.placeholder = ""
        
    }
    @objc func editEnd(){
        guard let textfield = self.textfield else {fatalError()}
        guard let placeholderText = self.placeholderText else {fatalError()}
        textfield.layer.borderColor = UIColor.systemGray5.cgColor
//        self.textfield.placeholder = self.placeholder
        placeholderText.textColor = UIColor.systemGray5
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield?.resignFirstResponder()
        if let delegation = delegate {
            delegation.textFieldPressReturn()
        }
        
        return true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

