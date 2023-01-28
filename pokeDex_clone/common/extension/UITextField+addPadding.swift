//
//  UITextField+addPadding.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/28.
//

import Foundation
import UIKit

extension UITextField {
    func addLeftPadding() {
        let blank = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = blank
        self.leftViewMode = .always
    }
}
