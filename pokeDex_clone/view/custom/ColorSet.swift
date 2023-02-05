//
//  Coloring.swift
//  pokeDex_clone
//
//  Created by Sang Hyeon kim on 2023/02/05.
//

import Foundation
import UIKit
class ColorSet {
    static let types: [String:String] = [
        "풀": "#43BE24",
        "독": "#994DCF",
        "불꽃" : "#FF612B",
        "비행" : "#95C9FF",
        "드래곤" : "#5462D6",
        "물" : "#2892FF",
        "벌레" : "#9FA423",
        "노말" : "#999999",
        "악" : "#4F4647",
        "전기" : "#FFDA00",
        "에스퍼" : "#FF627F",
        "땅" : "#AB7939",
        "얼음" : "#43D8FF",
        "강철" : "#6AAED2",
        "페어리" : "#FFB0FE",
        "격투" : "#FFA201",
        "바위" : "#BBB889",
        "고스트" : "#6E4570",
    ]
    
    static func pick(type: String) -> UIColor{
        guard let hexValue = types[type] else { return .black }
        print(hexValue)
        let result = UIColor(hexString: hexValue)
        return result
    }
    
}


extension UIColor {
//    public convenience init(hex: String) {
//        var r = 0.0
//        var g = 0.0
//        var b = 0.0
//        var a = 1.0
//
//        if hex.hasPrefix("#") {
//            let start = hex.index(hex.startIndex, offsetBy: 1)
//            let hexColor = String(hex[start...])
//
//            print("???", hexColor)
//            if hexColor.count == 6 {
//                let scanner = Scanner(string: hexColor)
//                var hexNumber: UInt64 = 0
//
//                if scanner.scanHexInt64(&hexNumber) {
//                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
//                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
//                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
//                    a = CGFloat(hexNumber & 0x000000ff) / 255
//                }
//            }
//        }
//
//        print(r,g,b,a)
//        self.init(red: r, green: g , blue: b , alpha: a)
//    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

}
