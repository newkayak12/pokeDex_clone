//
//  ViewController.swift
//  pokéDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/25.
//

import UIKit
import SnapKit
class MainViewController: UIViewController {
    let logoImageView = UIImageView()
    let logoImage = UIImage(named: "logo")
    var floatInputBox = FloatTextField(placeholder: "포켓몬 이름이나 번호, 타입 등을 입력하세요.")
    let inputBox = UITextField(frame: .zero)
    
    
    let tabBar = UITabBar(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("INIT!")
        view.backgroundColor = .systemBackground
        drawUI()
        drawTabBar()
        
    }
    
    func drawUI () {
        logoImageView.image = logoImage
        logoImageView.contentMode = .scaleAspectFit

        let imgWid = 353.0
        let imgHei = 245.33
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).priority(.high)
            make.trailing.equalTo(view.snp.trailing).priority(.high)
            make.size.width.lessThanOrEqualTo(imgWid).priority(.medium)
            make.centerX.equalTo(view.snp.centerX).priority(.low)
            make.centerY.equalTo(view.snp.centerY).priority(.low)
        }
        
        floatInputBox.textfield.borderStyle = .none
        floatInputBox.textfield.layer.borderColor = UIColor.systemGray5.cgColor
        floatInputBox.textfield.layer.borderWidth = CGFloat(3)
        floatInputBox.textfield.font = UIFont(name: (inputBox.font?.fontName)!, size: CGFloat(17))
        floatInputBox.textfield.layer.cornerRadius = 5
        floatInputBox.textfield.addLeftPadding()
        
        view.addSubview(floatInputBox.container)
        floatInputBox.container.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(100)
        }
        
//        inputBox.borderStyle = .none
//        inputBox.layer.borderColor = UIColor.systemGray5.cgColor
//        inputBox.layer.borderWidth = CGFloat(3)
//        inputBox.font = UIFont(name: (inputBox.font?.fontName)!, size: CGFloat(17))
//        inputBox.layer.cornerRadius = 5
//        inputBox.addLeftPadding()
//        inputBox.isHidden = true
//        inputBox.placeholder = "포켓몬 이름이나, 번호, 타입 등을 입력하세요."
        
//        view.addSubview(inputBox)
//        //        inputBox.isHidden = true
//        inputBox.snp.makeConstraints { make in
//            make.centerX.equalTo(view.snp.centerX)
//            make.centerY.equalTo(view.snp.centerY)
//            make.leading.equalTo(view.snp.leading).offset(20)
//            make.trailing.equalTo(view.snp.trailing).offset(-20)
//            make.height.equalTo(70)
//        }
        
        UIView.animate(withDuration: 8.0, delay: 4.0, options: [.transitionCrossDissolve]) { [weak self] in
            self!.logoImageView.snp.makeConstraints { make in
                make.size.width.equalTo(imgWid * 0.8).priority(.high)
                make.size.height.equalTo(imgHei * 0.8).priority(.high)
                make.centerY.equalTo(self!.view.snp.centerY).dividedBy(2)
                self!.inputBox.isHidden = false
            }
            self!.loadViewIfNeeded()
        }
        
    }
    
    func drawTabBar () {
        
        let homeImage = UIImage(systemName: "house.fill", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large))
        let favImage = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large))
//        homeImage?.configuration = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)
        let home = UITabBarItem(title: "Home", image: homeImage, tag: 0)
        let fav = UITabBarItem(title: "Favorite", image: favImage, tag: 1)
        
        
        
        
        tabBar.setItems([home, fav], animated: true)
        view.addSubview(tabBar)
        tabBar.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(50)
        }
    }
    
//    @objc func touchInput(sender: UITextField){
//        sender.layer.borderColor =  UIColor.systemRed.cgColor
//        print(sender)
//        let placeHolderLabel = sender.subviews.first(where: { NSStringFromClass(type(of: $0)) == "UITextFieldLabel" })
//
//        UIView.animate(withDuration: 1.0) {
//            // Animate place holder properties here
//            placeHolderLabel?.transform = CGAffineTransform(translationX: 100, y: 0)
//        }
//    }


}



