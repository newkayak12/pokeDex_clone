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
    var floatInputBox = FloatTextField()
    let inputBox = UITextField(frame: .zero)
    let searchButton = UIButton(type: .custom)
    
    let tabBar = UITabBar(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("INIT!")
        view.backgroundColor = .systemBackground
        floatInputBox.initiate(placeholder: "포켓몬 이름이나 번호, 타입 등을 입력하세요.")
        drawUI()
        addEventListener()
        
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
        
      
        floatInputBox.textfield!.borderStyle = .none
        floatInputBox.textfield!.layer.borderColor = UIColor.systemGray5.cgColor
        floatInputBox.textfield!.layer.borderWidth = CGFloat(3)
        floatInputBox.textfield!.font = UIFont(name: (inputBox.font?.fontName)!, size: CGFloat(17))
        floatInputBox.textfield!.layer.cornerRadius = 5
        floatInputBox.textfield!.addLeftPadding()
        
        view.addSubview(floatInputBox.container!)
        floatInputBox.container!.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(100)
        }
        
        UIView.animate(withDuration: 8.0, delay: 4.0, options: [.transitionCrossDissolve]) { [weak self] in
            self!.logoImageView.snp.makeConstraints { make in
                make.size.width.equalTo(imgWid * 0.8).priority(.high)
                make.size.height.equalTo(imgHei * 0.8).priority(.high)
                make.centerY.equalTo(self!.view.snp.centerY).dividedBy(2)
                self!.inputBox.isHidden = false
            }
            self!.loadViewIfNeeded()
        }
        
        searchButton.layer.masksToBounds = false
        searchButton.clipsToBounds = true
        
        
        searchButton.backgroundColor = UIColor(named: "AccentColor")
        let buttonImage = UIImageView()
        
        buttonImage.image = UIImage(systemName: "magnifyingglass")
        buttonImage.tintColor = .white
        searchButton.addSubview(buttonImage)
        buttonImage.snp.makeConstraints { make in
            make.centerX.equalTo(searchButton.snp.centerX)
            make.centerY.equalTo(searchButton.snp.centerY)
            make.size.equalTo(searchButton.snp.size).multipliedBy(0.5)
        }
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).multipliedBy(1.5)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        searchButton.layer.cornerRadius = 30
    }

    func addEventListener () {
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
    }
    
    @objc func search() {
        guard let searchText = floatInputBox.textfield!.text else {return}
        floatInputBox.textfield!.endEditing(true)
        let listViewModel = ListViewModel()
        listViewModel.search(searchText: searchText)
        let listViewController = ListViewController(listViewModel: listViewModel);
        
        
        
        let navigationController = UINavigationController(rootViewController: listViewController)
        listViewController.searchText = searchText
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    

}

extension MainViewController: FloatTextFieldDelegate {
    func textFieldPressReturn() {
        self.search()
    }
    
    
}



