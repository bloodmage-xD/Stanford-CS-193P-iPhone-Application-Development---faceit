//
//  ViewController.swift
//  faceit
//
//  Created by pokemon on 5/30/17.
//  Copyright © 2017 pokemon. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var faceView: faceview!{
        didSet{
            let handler = #selector(faceView.changescale(byReactingTo:))
            let pinchrecognize = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchrecognize)
            let taprecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleeyes(byReactingTo:)))
            faceView.addGestureRecognizer(taprecognizer)
            let swipeuprecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increasehappiness))
            swipeuprecognizer.direction = .up
            faceView.addGestureRecognizer(swipeuprecognizer)
            let swipedownrecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreasehappiness))
            swipedownrecognizer.direction = .down
            faceView.addGestureRecognizer(swipedownrecognizer)
            
            updateUI()
        }
    }
    func increasehappiness(){
        expression = expression.happier
    }
    func decreasehappiness(){
        expression = expression.sadder
    }
    
    func toggleeyes(byReactingTo tapRecognizer: UIPinchGestureRecognizer){
        if tapRecognizer.state == .ended{
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes : eyes, mouth : expression.mouth)
        }
        
    }
    var expression = FacialExpression(eyes: .open, mouth: .grin){
        didSet{
            updateUI()
        }
    }
    private func updateUI() {
        switch expression.eyes{
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squint:
            faceView?.eyesOpen = false
        }
    faceView?.mouthcurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    private let mouthCurvatures: [FacialExpression.Mouth: Double] = [
        .frown: -1.0, .smirk: -0.5, .neutral: 0.0, .grin: 0.5, .smile: 1.0
    ]
    
}

