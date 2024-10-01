//
//  File.swift
//  
//
//  Created by 서채희 on 2023/07/15.
//

import UIKit

extension UIColor {
    // MAR: - hsb color
    var hsb: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {
        var hsb: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat) = (0, 0, 0)
        self.getHue(&(hsb.hue), saturation: &(hsb.saturation), brightness: &(hsb.brightness), alpha: nil)
        return hsb
    }
    
    // MARK: - Make dark shadow color based on the origional color
    func makeDarkerColor(alpha: CGFloat = 1.0) -> UIColor {
        let h = self.hsb.hue
        let s = self.hsb.saturation <= 0.8 ?  self.hsb.saturation + 0.2 : 1.0
        let b = self.hsb.brightness >= 0.2 ?  self.hsb.brightness - 0.2 : 0.0
        return UIColor.init(hue: h, saturation: s, brightness: b, alpha: alpha)
    }
}
