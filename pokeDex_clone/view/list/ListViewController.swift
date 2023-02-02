//
//  ListViewController.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/02/01.
//

import UIKit

class ListViewController: UIViewController {
    var listViewModel: ListViewModel = ListViewModel()
    var searchText: String = ""
    let collectionView = UICollectionView(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()

        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        
        if let data = listViewModel.collectionData, data.count > 0 {
            
        } else {
            drawEmptyView()
        }
        
    }
    func drawCollectionView() {
        
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
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
