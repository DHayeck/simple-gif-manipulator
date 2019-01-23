//
//  ViewController.swift
//  Gif
//
//  Created by Lucien Dagher Hayeck on 26/08/16.
//  Copyright © 2016 Lucien Dagher Hayeck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animatedGIF: UIImageView!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    var i : Float = 0
    var oldForce : CGFloat = 0
    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            for i in 1..<20 {
                let str = String(i)+".tiff"
                imageArray.append(str)
            }
           
    }
    

    
    @IBAction func pan(sender: UIPanGestureRecognizer) {
        let velo : CGPoint = sender.velocity(in: animatedGIF)

        let interval :Float = 0.7
        let newI = i + ((velo.x > 0) ? interval : -interval)
        
        if (Int(newI) >= imageArray.index(of: imageArray.last!)! && velo.x >= 0) ||
            (newI <= 0 && velo.x <= 0) {
            return
        }
        
        animatedGIF.image = UIImage(named: imageArray[Int(i)])
        
        i = newI
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard #available(iOS 9.0, *), traitCollection.forceTouchCapability == UIForceTouchCapability.available else {
            return
        }
        
        let newForce = touches.first?.force
        let divider = Float((touches.first?.maximumPossibleForce)!)
        let x :Float = Float(imageArray.count)/divider
        var newI = Int(x*Float(newForce!)) - 1
        newI = (-1 == newI) ? 0 : newI
        print(">>>>>>>>>>>>>> \(Int(x*Float(newForce!)))")
        animatedGIF.image = UIImage(named: imageArray[newI])
        i = Float(newI)
        oldForce = newForce!
    }
}



