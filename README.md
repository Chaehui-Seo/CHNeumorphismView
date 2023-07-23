# CHNeumorphismView
<img width="1280" alt="neumorphism_preview*2" src="https://github.com/Chaehui-Seo/CHNeumorphismView/assets/73422344/b473b892-8e67-476e-8f16-8013fb95cfd5">



Neumorphism is a design style using shadows to make convex or concave effects on the background to express the elements, rather than floating on top of the background.
### ⚠️ still in progress ⚠️

## Requirements
- iOS 11.0+

## Installation
### Swift Package Manager
Use [Swift Package Manager](https://swift.org/package-manager/) by adding following line to `Package.swift`:
```
dependencies: [
 .package(url: "https://github.com/Chaehui-Seo/CHNeumorphismView.git", from: "0.0.1")
]
```

## Usage
### Create neumorphismView
METHOD #1 <br>
Make UIView as neumorphism view by changing the Custom Class to `CHNeumorphismView`.
<img width="981" alt="explain1" src="https://github.com/Chaehui-Seo/CHNeumorphismView/assets/73422344/88d3dee1-00a3-417c-a0e0-b5b39592423d">


Default CHNeumorphismView would look like below.
| Curve Direction | Intensity | Dark Shadow Color | Light Shadow Color |
| :-: | :-: | :-: | :-: |
| Outside (Convex) | 1 (Maximum value) | Based on background Color | White |

<img width="194" alt="defaultValue" src="https://github.com/Chaehui-Seo/CHNeumorphismView/assets/73422344/c69248d9-c04b-4b27-8d01-3450f90b9b18">
