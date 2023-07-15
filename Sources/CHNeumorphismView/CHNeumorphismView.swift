import UIKit

public class CHNeumorphismView: UIView {
    private var blackShadowView = UIView()
    private var whiteShadowView = UIView()
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            blackShadowView.layer.cornerRadius = newValue
            whiteShadowView.layer.cornerRadius = newValue
        }
    }
    
    public enum CHNeumorphismCurve {
        case inside
        case outside
    }
    
    public func makeNeumorphismEffect(curve: CHNeumorphismCurve,
                                      darkShadowColor: UIColor? = nil,
                                      lightShadowColor: UIColor? = nil) {
        switch curve {
        case .inside:
            makeEngravedEffect(darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor)
        case .outside:
            makeEmbossedEffect(darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor)
        }
    }
    
    private func makeEmbossedEffect(darkShadowColor: UIColor? = nil, lightShadowColor: UIColor? = nil) {
        blackShadowView.removeFromSuperview()
        whiteShadowView.removeFromSuperview()
        
        blackShadowView = UIView(frame: self.bounds)
        blackShadowView.backgroundColor = .white
        blackShadowView.layer.cornerRadius = self.layer.cornerRadius
        blackShadowView.translatesAutoresizingMaskIntoConstraints = false
        blackShadowView.clipsToBounds = true
        blackShadowView.layer.shadowColor = darkShadowColor != nil ? darkShadowColor?.cgColor : self.backgroundColor?.makeDarkerColor().cgColor
        blackShadowView.layer.shadowOpacity = 0.5
        blackShadowView.layer.shadowOffset = CGSize(width: 10, height: 10)
        blackShadowView.layer.shadowRadius = 5
        blackShadowView.layer.shouldRasterize = true
        blackShadowView.layer.masksToBounds = false
        
        
        whiteShadowView = UIView(frame: self.bounds)
        whiteShadowView.backgroundColor = .white
        whiteShadowView.layer.cornerRadius = self.layer.cornerRadius
        whiteShadowView.translatesAutoresizingMaskIntoConstraints = false
        whiteShadowView.clipsToBounds = true
        whiteShadowView.layer.shadowColor = lightShadowColor != nil ? lightShadowColor?.cgColor : UIColor.white.cgColor
        whiteShadowView.layer.shadowOpacity = 0.9
        whiteShadowView.layer.shadowOffset = CGSize(width: -10, height: -10)
        whiteShadowView.layer.shadowRadius = 5
        whiteShadowView.layer.shouldRasterize = true
        whiteShadowView.layer.masksToBounds = false
        
        self.superview?.insertSubview(blackShadowView, belowSubview: self)
        self.superview?.insertSubview(whiteShadowView, belowSubview: self)
        NSLayoutConstraint.activate([
            blackShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blackShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blackShadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blackShadowView.topAnchor.constraint(equalTo: self.topAnchor),
            whiteShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            whiteShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            whiteShadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            whiteShadowView.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }
    
    private func makeEngravedEffect(darkShadowColor: UIColor? = nil, lightShadowColor: UIColor? = nil) {
        blackShadowView.removeFromSuperview()
        whiteShadowView.removeFromSuperview()
        
        // Black shadow setting
        blackShadowView = UIView(frame: self.bounds)
        blackShadowView.layer.cornerRadius = self.layer.cornerRadius
        blackShadowView.translatesAutoresizingMaskIntoConstraints = false
        blackShadowView.clipsToBounds = true
        blackShadowView.layer.shadowColor = darkShadowColor != nil ? darkShadowColor?.cgColor : self.backgroundColor?.makeDarkerColor().cgColor
        blackShadowView.layer.shadowOpacity = 0.5
        blackShadowView.layer.shadowOffset = CGSize(width: 10, height: 10)
        blackShadowView.layer.shadowRadius = 5
        blackShadowView.layer.shouldRasterize = true
        blackShadowView.layer.masksToBounds = true
        
        let blackPath = UIBezierPath()
        blackPath.move(to: CGPoint(x: 0, y: self.bounds.height))
        blackPath.addLine(to: CGPoint(x: -50, y: self.bounds.height))
        blackPath.addLine(to: CGPoint(x: -50, y: -50))
        blackPath.addLine(to: CGPoint(x: self.bounds.width, y: -50))
        blackPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        blackPath.addLine(to: CGPoint(x: self.layer.cornerRadius, y: 0))
        blackPath.addArc(withCenter: CGPoint(x: self.layer.cornerRadius, y: self.layer.cornerRadius), radius: self.layer.cornerRadius, startAngle: .pi * 3 / 2, endAngle: .pi, clockwise: false)
        blackPath.close()
        
        let blackShapeLayer = CAShapeLayer()
        blackShapeLayer.path = blackPath.cgPath
        blackShapeLayer.fillColor = UIColor.white.cgColor // This backgroundColor will not be displayed since it is outside of the superView(=self)
        blackShadowView.layer.addSublayer(blackShapeLayer)
        
        // White shadow setting
        whiteShadowView = UIView(frame: self.bounds)
        whiteShadowView.layer.cornerRadius = self.layer.cornerRadius
        whiteShadowView.translatesAutoresizingMaskIntoConstraints = false
        whiteShadowView.clipsToBounds = true
        whiteShadowView.layer.shadowColor = lightShadowColor != nil ? lightShadowColor?.cgColor : UIColor.white.cgColor
        whiteShadowView.layer.shadowOpacity = 0.9
        whiteShadowView.layer.shadowOffset = CGSize(width: -10, height: -10)
        whiteShadowView.layer.shadowRadius = 5
        whiteShadowView.layer.shouldRasterize = true
        whiteShadowView.layer.masksToBounds = true
        
        let whitePath = UIBezierPath()
        whitePath.move(to: CGPoint(x: self.bounds.width, y: 0))
        whitePath.addLine(to: CGPoint(x: self.bounds.width + 50, y: 0))
        whitePath.addLine(to: CGPoint(x: self.bounds.width + 50, y: self.bounds.height + 50))
        whitePath.addLine(to: CGPoint(x: 0, y: self.bounds.height + 50))
        whitePath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        whitePath.addLine(to: CGPoint(x: self.bounds.width - self.layer.cornerRadius, y: self.bounds.height))
        whitePath.addArc(withCenter: CGPoint(x: self.bounds.width - self.layer.cornerRadius, y: self.bounds.height - self.layer.cornerRadius), radius: self.layer.cornerRadius, startAngle: .pi / 2, endAngle: 0, clockwise: false)
        whitePath.close()
        
        let whiteShapeLayer = CAShapeLayer()
        whiteShapeLayer.path = whitePath.cgPath
        whiteShapeLayer.fillColor = UIColor.white.cgColor // This backgroundColor will not be displayed since it is outside of the superView(=self)
        whiteShadowView.layer.addSublayer(whiteShapeLayer)
        
        // Add set shadows
        self.addSubview(blackShadowView)
        self.addSubview(whiteShadowView)
        NSLayoutConstraint.activate([
            blackShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blackShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blackShadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blackShadowView.topAnchor.constraint(equalTo: self.topAnchor),
            whiteShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            whiteShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            whiteShadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            whiteShadowView.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }
}


fileprivate extension UIColor {
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
