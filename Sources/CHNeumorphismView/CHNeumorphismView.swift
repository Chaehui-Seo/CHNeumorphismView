import UIKit

@IBDesignable
public class CHNeumorphismView: UIView {
    // MARK: - Public DataType
    public enum CHNeumorphismCurve {
        case inside
        case outside
    }
    
    // MARK: - Private Properties
    private var darkShadowView = UIView()
    private var lightShadowView = UIView()
    
    private var currentCurveDirection: CHNeumorphismCurve?
    private var currentDarkShadowColor: UIColor? = nil
    private var currentLightShadowColor: UIColor? = nil
    private var currentIntensity: CGFloat = 1
    
    // MARK: - Inspectabl Property
    /// Value of CHNeumorphismView's corner Radius
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            darkShadowView.layer.cornerRadius = newValue
            lightShadowView.layer.cornerRadius = newValue
            setEffect()
        }
    }
    
    /// Whether the direction of effect is convex
    @IBInspectable public var isCurveOutside: Bool {
        get {
            currentCurveDirection = .outside
            return true
        }
        set {
            switch newValue {
            case true:
                currentCurveDirection = .outside
                setEffect()
            case false:
                currentCurveDirection = .inside
                setEffect()
            }
        }
    }
    
    /// Intensity value of effect (value between 0 ~ 1, default value is 1)
    @IBInspectable public var effectIntensity: CGFloat {
        get {
            currentIntensity = 1.0
            return 1.0
        }
        set {
            var tempNewValue = newValue
            if newValue < 0.0 {
                tempNewValue = 0.0
            } else if newValue > 1.0 {
                tempNewValue = 1.0
            }
            currentIntensity = tempNewValue
            setEffect()
        }
    }
    
    /// Shadow color of the dark side (default value is decided based on the background color)
    @IBInspectable public var darkShadowColor: UIColor? {
        get {
            currentDarkShadowColor = nil
            return nil
        }
        set {
            currentDarkShadowColor = newValue
            setEffect()
        }
    }
    
    /// Shadow color of the light side (default value is white)
    @IBInspectable public var lightShadowColor: UIColor? {
        get {
            currentLightShadowColor = nil
            return nil
        }
        set {
            currentLightShadowColor = newValue
            setEffect()
        }
    }
    
    // MARK: -  Initialize method
    public override func awakeFromNib() {
        super.awakeFromNib()
        setEffect()
    }
    
    // MARK: - Public Method
    /// Apply neumorphism effect to the CHNeumorphismView
    /// - Parameters:
    ///     - curve: direction to apply effect (.outside for convex, .inside for concave)
    ///     - intensity: intensity of the effect (value between 0 ~ 1, default value is 1)
    ///     - darkShadowColor: shadow color for the dark side (default value is decided based on the background color)
    ///     - lightShadowColor: shadow color for the light side (default value is white)
    public func makeNeumorphismEffect(curve: CHNeumorphismCurve,
                                      intensity: CGFloat = 1,
                                      darkShadowColor: UIColor? = nil,
                                      lightShadowColor: UIColor? = nil) {
        self.currentCurveDirection = curve
        self.currentDarkShadowColor = darkShadowColor
        self.currentLightShadowColor = lightShadowColor
        self.currentIntensity = intensity
        switch curve {
        case .inside:
            makeConcaveEffect(intensity: intensity, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor)
        case .outside:
            makeConvexEffect(intensity: intensity, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor)
        }
    }
    
    // MARK: - Private Method
    private func setEffect() {
        guard let curveDirection = currentCurveDirection else { return }
        makeNeumorphismEffect(curve: curveDirection,
                              intensity: currentIntensity,
                              darkShadowColor: currentDarkShadowColor,
                              lightShadowColor: currentLightShadowColor)
    }
    
    private func makeConvexEffect(intensity: CGFloat = 1, darkShadowColor: UIColor? = nil, lightShadowColor: UIColor? = nil) {
        darkShadowView.removeFromSuperview()
        lightShadowView.removeFromSuperview()
        
        darkShadowView = UIView(frame: self.bounds)
        darkShadowView.backgroundColor = darkShadowColor != nil
                                            ? darkShadowColor
                                            : self.backgroundColor?.makeDarkerColor()
        darkShadowView.layer.cornerRadius = self.layer.cornerRadius
        darkShadowView.translatesAutoresizingMaskIntoConstraints = false
        darkShadowView.clipsToBounds = true
        darkShadowView.layer.shadowColor = darkShadowColor != nil
                                            ? darkShadowColor?.cgColor
                                            : self.backgroundColor?.makeDarkerColor().cgColor
        darkShadowView.layer.shadowOpacity = Float(0.8 * intensity)
        darkShadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        darkShadowView.layer.shadowRadius = 5
        darkShadowView.layer.shouldRasterize = true
        darkShadowView.layer.masksToBounds = false
        
        
        lightShadowView = UIView(frame: self.bounds)
        lightShadowView.backgroundColor = self.backgroundColor
        lightShadowView.layer.cornerRadius = self.layer.cornerRadius
        lightShadowView.translatesAutoresizingMaskIntoConstraints = false
        lightShadowView.clipsToBounds = true
        lightShadowView.layer.shadowColor = lightShadowColor != nil
                                            ? lightShadowColor?.cgColor
                                            : UIColor.white.cgColor
        lightShadowView.layer.shadowOpacity = Float(0.8 * intensity)
        lightShadowView.layer.shadowOffset = CGSize(width: -5, height: -5)
        lightShadowView.layer.shadowRadius = 5
        lightShadowView.layer.shouldRasterize = true
        lightShadowView.layer.masksToBounds = false
        
        self.superview?.insertSubview(darkShadowView, belowSubview: self)
        self.superview?.insertSubview(lightShadowView, belowSubview: self)
        NSLayoutConstraint.activate([
            darkShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            darkShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            darkShadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            darkShadowView.topAnchor.constraint(equalTo: self.topAnchor),
            lightShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lightShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lightShadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lightShadowView.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }
    
    private func makeConcaveEffect(intensity: CGFloat = 1, darkShadowColor: UIColor? = nil, lightShadowColor: UIColor? = nil) {
        layoutIfNeeded()
        darkShadowView.removeFromSuperview()
        lightShadowView.removeFromSuperview()
        
        // Dark shadow setting
        darkShadowView = UIView(frame: self.bounds)
        darkShadowView.layer.cornerRadius = self.layer.cornerRadius
        darkShadowView.translatesAutoresizingMaskIntoConstraints = false
        darkShadowView.clipsToBounds = true
        darkShadowView.layer.shadowColor = darkShadowColor != nil
                                            ? darkShadowColor?.cgColor
                                            : self.backgroundColor?.makeDarkerColor().cgColor
        darkShadowView.layer.shadowOpacity = Float(0.8 * intensity)
        darkShadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        darkShadowView.layer.shadowRadius = 5
        darkShadowView.layer.shouldRasterize = true
        darkShadowView.layer.masksToBounds = true
        
        let darkPath = UIBezierPath()
        darkPath.move(to: CGPoint(x: 0, y: self.bounds.height))
        darkPath.addLine(to: CGPoint(x: -50, y: self.bounds.height))
        darkPath.addLine(to: CGPoint(x: -50, y: -50))
        darkPath.addLine(to: CGPoint(x: self.bounds.width, y: -50))
        darkPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        darkPath.addLine(to: CGPoint(x: self.layer.cornerRadius, y: 0))
        darkPath.addArc(withCenter: CGPoint(x: self.layer.cornerRadius, y: self.layer.cornerRadius), radius: self.layer.cornerRadius, startAngle: .pi * 3 / 2, endAngle: .pi, clockwise: false)
        darkPath.close()
        
        let darkShapeLayer = CAShapeLayer()
        darkShapeLayer.path = darkPath.cgPath
        darkShapeLayer.fillColor = darkShadowColor != nil
                                    ? darkShadowColor?.cgColor
                                    : self.backgroundColor?.makeDarkerColor().cgColor
        darkShadowView.layer.addSublayer(darkShapeLayer)
        
        // Light shadow setting
        lightShadowView = UIView(frame: self.bounds)
        lightShadowView.layer.cornerRadius = self.layer.cornerRadius
        lightShadowView.translatesAutoresizingMaskIntoConstraints = false
        lightShadowView.clipsToBounds = true
        lightShadowView.layer.shadowColor = lightShadowColor != nil
                                            ? lightShadowColor?.cgColor
                                            : UIColor.white.cgColor
        lightShadowView.layer.shadowOpacity = Float(0.8 * intensity) // Shadow of concave effect could cover the contents of the view. Therefore, default opacity value should be more transparent than the one in convex effect
        lightShadowView.layer.shadowOffset = CGSize(width: -5, height: -5)
        lightShadowView.layer.shadowRadius = 5
        lightShadowView.layer.shouldRasterize = true
        lightShadowView.layer.masksToBounds = true
        
        let lightPath = UIBezierPath()
        lightPath.move(to: CGPoint(x: self.bounds.width, y: 0))
        lightPath.addLine(to: CGPoint(x: self.bounds.width + 50, y: 0))
        lightPath.addLine(to: CGPoint(x: self.bounds.width + 50, y: self.bounds.height + 50))
        lightPath.addLine(to: CGPoint(x: 0, y: self.bounds.height + 50))
        lightPath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        lightPath.addLine(to: CGPoint(x: self.bounds.width - self.layer.cornerRadius, y: self.bounds.height))
        lightPath.addArc(withCenter: CGPoint(x: self.bounds.width - self.layer.cornerRadius, y: self.bounds.height - self.layer.cornerRadius), radius: self.layer.cornerRadius, startAngle: .pi / 2, endAngle: 0, clockwise: false)
        lightPath.close()
        
        let lightShapeLayer = CAShapeLayer()
        lightShapeLayer.path = lightPath.cgPath
        lightShapeLayer.fillColor = self.backgroundColor?.cgColor
        lightShadowView.layer.addSublayer(lightShapeLayer)
        
        // Add set shadows
        self.addSubview(darkShadowView)
        self.addSubview(lightShadowView)
        NSLayoutConstraint.activate([
            darkShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            darkShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            darkShadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            darkShadowView.topAnchor.constraint(equalTo: self.topAnchor),
            lightShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lightShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lightShadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lightShadowView.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }
}
