//
//  UITabBar+autoHeight.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/01/28.
//

import Foundation
import UIKit
extension UITabBar {
    
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 50
        return sizeThatFits
    }
}
