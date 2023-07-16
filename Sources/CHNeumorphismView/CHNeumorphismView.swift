import UIKit

public class CHNeumorphismView: UIView {
    // MARK: - Public DataType
    public enum CHNeumorphismCurve {
        case inside
        case outside
    }
    
    // MARK: - Private Properties
    private var blackShadowView = UIView()
    private var whiteShadowView = UIView()
    
    private var currentCurveDirection: CHNeumorphismCurve?
    private var currentDarkShadowColor: UIColor? = nil
    private var currentLightShadowColor: UIColor? = nil
    private var currentIntensity: CGFloat = 1
    
    // MARK: - Inspectabl Property
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            blackShadowView.layer.cornerRadius = newValue
            whiteShadowView.layer.cornerRadius = newValue
            
            // To make sure the view adjust the changed cornerRadius, in case neumorphismEffect was set before.
            guard let curve = currentCurveDirection else { return }
            makeNeumorphismEffect(curve: curve,
                                  darkShadowColor: currentDarkShadowColor,
                                  lightShadowColor: currentLightShadowColor,
                                  intensity: currentIntensity)
        }
    }
    
    // MARK: - Public Method
    /// Apply neumorphism effect to the CHNeumorphismView
    /// - Parameters:
    ///     - curve: direction to apply effect (.outside for convex, .inside for concave)
    ///     - darkShadowColor: shadow color for the dark side (default value is decided based on the background color)
    ///     - lightShadowColor: shadow color for the light side (default value is white)
    ///     - intensity: intensity of the effect (value between 0 ~ 1, default value is 1)
    public func makeNeumorphismEffect(curve: CHNeumorphismCurve,
                                      darkShadowColor: UIColor? = nil,
                                      lightShadowColor: UIColor? = nil,
                                      intensity: CGFloat = 1) {
        self.currentCurveDirection = curve
        self.currentDarkShadowColor = darkShadowColor
        self.currentLightShadowColor = lightShadowColor
        self.currentIntensity = intensity
        switch curve {
        case .inside:
            makeConcaveEffect(darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, intensity: intensity)
        case .outside:
            makeConvexEffect(darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, intensity: intensity)
        }
    }
    
    // MARK: - Private Method
    private func makeConvexEffect(darkShadowColor: UIColor? = nil, lightShadowColor: UIColor? = nil, intensity: CGFloat = 1) {
        blackShadowView.removeFromSuperview()
        whiteShadowView.removeFromSuperview()
        
        blackShadowView = UIView(frame: self.bounds)
        blackShadowView.backgroundColor = .white
        blackShadowView.layer.cornerRadius = self.layer.cornerRadius
        blackShadowView.translatesAutoresizingMaskIntoConstraints = false
        blackShadowView.clipsToBounds = true
        blackShadowView.layer.shadowColor = darkShadowColor != nil ? darkShadowColor?.cgColor : self.backgroundColor?.makeDarkerColor().cgColor
        blackShadowView.layer.shadowOpacity = Float(0.5 * intensity)
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
        whiteShadowView.layer.shadowOpacity = Float(0.9 * intensity)
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
    
    private func makeConcaveEffect(darkShadowColor: UIColor? = nil, lightShadowColor: UIColor? = nil, intensity: CGFloat = 1) {
        blackShadowView.removeFromSuperview()
        whiteShadowView.removeFromSuperview()
        
        // Black shadow setting
        blackShadowView = UIView(frame: self.bounds)
        blackShadowView.layer.cornerRadius = self.layer.cornerRadius
        blackShadowView.translatesAutoresizingMaskIntoConstraints = false
        blackShadowView.clipsToBounds = true
        blackShadowView.layer.shadowColor = darkShadowColor != nil ? darkShadowColor?.cgColor : self.backgroundColor?.makeDarkerColor().cgColor
        blackShadowView.layer.shadowOpacity = Float(0.5 * intensity)
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
        whiteShadowView.layer.shadowOpacity = Float(0.9 * intensity)
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
