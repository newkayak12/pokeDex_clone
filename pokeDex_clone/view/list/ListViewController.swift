//
//  ListViewController.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/02/01.
//

import UIKit

class ListViewController: UIViewController {
    var listViewModel: ListViewModel?
    var searchText: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        listViewModel = ListViewModel()
        

        // Do any additional setup after loading the view.
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
