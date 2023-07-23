//
//  ViewController.swift
//  SampleApp
//
//  Created by 서채희 on 2023/07/10.
//

import UIKit
import CHNeumorphismView

class SampleAppViewController: UIViewController {
    @IBOutlet weak var squareView1: CHNeumorphismView!
    @IBOutlet weak var squareView2: CHNeumorphismView!
    @IBOutlet weak var squareView3: CHNeumorphismView!
    @IBOutlet weak var squareView4: CHNeumorphismView!
    
    @IBOutlet weak var rectangleView1: CHNeumorphismView!
    @IBOutlet weak var rectangleView2: CHNeumorphismView!
    @IBOutlet weak var barView1: CHNeumorphismView!
    @IBOutlet weak var barProgressView1: UIView!
    @IBOutlet weak var barView2: CHNeumorphismView!
    @IBOutlet weak var barProgressView2: UIView!
    
    @IBOutlet weak var intensitySlider: UISlider!
    @IBOutlet weak var cornerSlider: UISlider!
    @IBOutlet weak var colorSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intensitySlider.minimumValue = 0
        intensitySlider.maximumValue = 1
        intensitySlider.value = 0.8
        cornerSlider.minimumValue = 0
        cornerSlider.maximumValue = 30
        cornerSlider.value = 30
        colorSlider.minimumValue = 0
        colorSlider.maximumValue = 360
        colorSlider.value = 216
        
        squareView1.cornerRadius = 30
        squareView2.cornerRadius = 30
        squareView3.cornerRadius = 30
        squareView4.cornerRadius = 30
        squareView1.makeNeumorphismEffect(curve: .inside, intensity: 0.8)
        squareView2.makeNeumorphismEffect(curve: .inside, intensity: 0.8)
        squareView3.makeNeumorphismEffect(curve: .outside, intensity: 0.8)
        squareView4.makeNeumorphismEffect(curve: .outside, intensity: 0.8)
        
        rectangleView1.cornerRadius = 30
        rectangleView2.cornerRadius = 30
        rectangleView1.makeNeumorphismEffect(curve: .outside, intensity: 0.8)
        rectangleView2.makeNeumorphismEffect(curve: .inside, intensity: 0.8)
        
        barView1.cornerRadius = 10
        barView1.makeNeumorphismEffect(curve: .outside, intensity: 0.8)
        barView2.cornerRadius = 10
        barView2.makeNeumorphismEffect(curve: .inside, intensity: 0.8)
        barProgressView1.layer.cornerRadius = 10
        barProgressView2.layer.cornerRadius = 10
    }
    
    @IBAction func intensityValueChanged(_ sender: Any) {
        let intensityValue = CGFloat(intensitySlider.value)
        changeIntensity(intensityValue: intensityValue)
    }
    
    private func changeIntensity(intensityValue: CGFloat) {
        squareView1.effectIntensity = intensityValue
        squareView2.effectIntensity = intensityValue
        squareView3.effectIntensity = intensityValue
        squareView4.effectIntensity = intensityValue
        rectangleView1.effectIntensity = intensityValue
        rectangleView2.effectIntensity = intensityValue
        barView1.effectIntensity = intensityValue
        barView2.effectIntensity = intensityValue
    }
    
    @IBAction func cornerRadiusValueChanged(_ sender: Any) {
        let cornerRadiusValue = CGFloat(cornerSlider.value)
        changeCornerRadius(cornerRadiusValue: cornerRadiusValue)
    }
    
    private func changeCornerRadius(cornerRadiusValue: CGFloat) {
        squareView1.cornerRadius = cornerRadiusValue
        squareView2.cornerRadius = cornerRadiusValue
        squareView3.cornerRadius = cornerRadiusValue
        squareView4.cornerRadius = cornerRadiusValue
        rectangleView1.cornerRadius = cornerRadiusValue
        rectangleView2.cornerRadius = cornerRadiusValue
        barView1.cornerRadius = cornerRadiusValue / 3
        barView2.cornerRadius = cornerRadiusValue / 3
        barProgressView1.layer.cornerRadius = cornerRadiusValue / 3
        barProgressView2.layer.cornerRadius = cornerRadiusValue / 3
    }
    
    @IBAction func colorValueChanged(_ sender: Any) {
        let hueValue = CGFloat(colorSlider.value)
        let newColor = UIColor(hue: hueValue / 360 , saturation: 8 / 100, brightness: 100 / 100, alpha: 1)
        changeBackgroundWithDarkShadow(color: newColor)
    }
    
    private func changeBackgroundWithDarkShadow(color: UIColor) {
        self.view.backgroundColor = color
        squareView1.backgroundColor = color
        squareView2.backgroundColor = color
        squareView3.backgroundColor = color
        squareView4.backgroundColor = color
        rectangleView1.backgroundColor = color
        rectangleView2.backgroundColor = color
        barView1.backgroundColor = color
        barView2.backgroundColor = color
        
        squareView1.darkShadowColor = color.darkerColor()
        squareView2.darkShadowColor = color.darkerColor()
        squareView3.darkShadowColor = color.darkerColor()
        squareView4.darkShadowColor = color.darkerColor()
        rectangleView1.darkShadowColor = color.darkerColor()
        rectangleView2.darkShadowColor = color.darkerColor()
        
        barView1.darkShadowColor = color.darkerColor()
        barView2.darkShadowColor = color.darkerColor()
    }
    
    @IBAction func resetButtonDidTap(_ sender: Any) {
        intensitySlider.value = 0.8
        changeIntensity(intensityValue: 0.8)
        
        cornerSlider.value = 30
        changeCornerRadius(cornerRadiusValue: 30)
        
        colorSlider.value = 216
        let defaultColor = UIColor(hue: 216 / 360 , saturation: 8 / 100, brightness: 100 / 100, alpha: 1)
        changeBackgroundWithDarkShadow(color: defaultColor)
    }
}

// Temp extension to generate dark shadow color in Sample App. (Same codes are placed inside the library)
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
    func darkerColor(alpha: CGFloat = 1.0) -> UIColor {
        let h = self.hsl.hue / 360.0
        var s = self.hsl.saturation / 100 > 0.3 ? 0.3 : 0.0
        let l = self.hsl.lightness / 100 - 0.3
        
        let t = s * ((l < 0.5) ? l : (1.0 - l))
        let b = l + t
        s = (l > 0.0) ? (2.0 * t / b) : 0.0

        return UIColor.init(hue: h, saturation: s, brightness: b, alpha: alpha)
    }
}
