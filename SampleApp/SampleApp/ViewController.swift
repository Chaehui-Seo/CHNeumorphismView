//
//  ViewController.swift
//  SampleApp
//
//  Created by 서채희 on 2023/07/10.
//

import UIKit
import CHNeumorphismView

class ViewController: UIViewController {
    @IBOutlet weak var targetView: CHNeumorphismView!
    @IBOutlet weak var targetView2: CHNeumorphismView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        targetView.cornerRadius = 50
        targetView.makeNeumorphismEffect(curve: .outside)
        
        targetView2.cornerRadius = 50
        targetView2.makeNeumorphismEffect(curve: .inside)
    }


}

