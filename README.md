# CHNeumorphismView
<img width="1280" alt="frontPhoto" src="https://github.com/user-attachments/assets/36bdac3a-7ac3-4bd5-9dee-d32efc4b84fb">

Neumorphism is a design style using shadows below or above the elements to make convex or concave effects.

# Requirements
- iOS 11.0+

# Installation
### Swift Package Manager
Use [Swift Package Manager](https://swift.org/package-manager/) by adding following line to `Package.swift`:
```
dependencies: [
 .package(url: "https://github.com/Chaehui-Seo/CHNeumorphismView.git", from: "1.0.0")
]
```

# Usage
### Create neumorphismView
Make UIView as neumorphism view by changing the Custom Class to `CHNeumorphismView`.
<img width="981" alt="explain1" src="https://github.com/Chaehui-Seo/CHNeumorphismView/assets/73422344/ff352ec0-553d-4325-b9bd-28cdd17549f3">


Default CHNeumorphismView would look like below.
| Curve Direction | Intensity | Dark Shadow Color | Light Shadow Color |
| :-: | :-: | :-: | :-: |
| Outside (Convex) | 1 (Maximum value) | Based on background Color | White |
<img width="194" alt="defaultValue" src="https://github.com/Chaehui-Seo/CHNeumorphismView/assets/73422344/bbefdd7c-1b90-4439-8f34-6fa3f885b1b0">


# Customizing options
All of the customizing options can be set either in the storyboard or with codes.
You can change it in the storyboard by set the value of the inspectors like below.
<img width="988" alt="explain2" src="https://github.com/Chaehui-Seo/CHNeumorphismView/assets/73422344/f59e186c-3964-4415-a39a-147053233c96">

You can apply the effect with various options at once with public method.
```swift
// MARK: - [Make Neumorphism Effect at once]
// Curve Direction is the only essential parameter.
neumorphismView.makeNeumorphismEffect(curve: .outside) // for outside curve (= convex)
neumorphismView.makeNeumorphismEffect(curve: .inside) // for inside curve (= concave)
    
// Intensity is not essential and the default value is 1, which is the maximum value.
// Intensity value can be set between 0 ~ 1
neumorphismView.makeNeumorphismEffect(curve: .outside, intensity: 0.8)
    
// Dark or light shadow color can be set as you want.
// If you don't set the color value, dark shadow color will be decided based on the background color,
// and light shadow color will be set as white.
neumorphismView.makeNeumorphismEffect(curve: .inside, intensity: 0.8, darkShadowColor: UIColor.gray)
neumorphismView.makeNeumorphismEffect(curve: .inside, intensity: 0.8, lightShadowColor: UIColor.yellow)
neumorphismView.makeNeumorphismEffect(curve: .inside, intensity: 0.8, darkShadowColor: UIColor.gray, lightShadowColor: UIColor.yellow)
```

Or you can modity the options one by one.
```swift
// MARK: - [Curve Direction]
neumorphismView.isCurveOutside = true // for outside curve (= convex)
neumorphismView.isCurveOutside = false // for inside curve (= concave)
```

```swift
// MARK: - [Effect Intensity]
neumorphismView.effectIntensity = 0.5 // value between 0 ~ 1, default value is 1
```

```swift
// MARK: - [Corner Radius]
neumorphismView.cornerRadius = 10 // Use it rather than 'layer.cornerRadius' to apply corner to the effect
```

```swift
// MARK: - [Shadow Color]
neumorphismView.darkShadowColor = UIColor( ... ) // default value is set based on the background color
neumorphismView.lightShadowColor = UIColor( ... ) // default value is .white
```

# SampleApp
You can run SampleApp Project located in `SampleApp` folder.
All the functions that provided by the package are testable through the SampleApp project.

![Simulator Screen Recording - iPhone 14 Pro - 2023-08-06 at 19 44 26](https://github.com/Chaehui-Seo/CHNeumorphismView/assets/73422344/42f6ff56-5405-45da-80ac-b30840d1e634)


# Caution
- Make sure to apply the effect AFTER setting the layout of the target view.
- Since neumorphism UI uses shadows to express depth, transparent colors(alpha < 1) are NOT recommended as a background color.
