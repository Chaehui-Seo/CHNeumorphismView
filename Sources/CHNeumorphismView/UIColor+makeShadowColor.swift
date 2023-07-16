//
//  File.swift
//  
//
//  Created by 서채희 on 2023/07/15.
//

import UIKit

extension UIColor {
    // MAR: - hsl color
    struct HSL: Hashable {
        var hue: CGFloat // 0 - 360
        var saturation: CGFloat // 0 - 100
        var lightness: CGFloat // 0 - 100
    }

    var hsl: HSL {
        var (h, s, b) = (CGFloat(), CGFloat(), CGFloat())
        getHue(&h, saturation: &s, brightness: &b, alpha: nil)
        let l = ((2.0 - s) * b) / 2.0

        switch l {
        case 0.0, 1.0:
            s = 0.0
        case 0.0..<0.5:
            s = (s * b) / (l * 2.0)
        default:
            s = (s * b) / (2.0 - l * 2.0)
        }

        return HSL(hue: h * 360.0,
                   saturation: s * 100.0,
                   lightness: l * 100.0)
    }
    
    convenience init(_ hsl: HSL, alpha: CGFloat = 1.0) {
        let h = hsl.hue / 360.0
        var s = hsl.saturation / 100.0
        let l = hsl.lightness / 100.0

        let t = s * ((l < 0.5) ? l : (1.0 - l))
        let b = l + t
        s = (l > 0.0) ? (2.0 * t / b) : 0.0

        self.init(hue: h, saturation: s, brightness: b, alpha: alpha)
    }
    
    // MARK: - Make dark shadow color based on the origional color
    func makeDarkerColor(alpha: CGFloat = 1.0) -> UIColor {
        let h = self.hsl.hue / 360.0
        var s = self.hsl.saturation / 100 > 0.3 ? 0.3 : 0.0
        let l = self.hsl.lightness / 100 - 0.3
        
        let t = s * ((l < 0.5) ? l : (1.0 - l))
        let b = l + t
        s = (l > 0.0) ? (2.0 * t / b) : 0.0

        return UIColor.init(hue: h, saturation: s, brightness: b, alpha: alpha)
    }
}
