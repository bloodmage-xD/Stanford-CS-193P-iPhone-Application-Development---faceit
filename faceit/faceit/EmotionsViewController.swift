//
//  EmotionsViewController.swift
//  faceit
//
//  Created by pokemon on 6/5/17.
//  Copyright © 2017 pokemon. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        if let navtigationcontroller = destinationViewController as? UINavigationController{
            destinationViewController = navtigationcontroller.visibleViewController ?? destinationViewController
        }
        if let FaceViewController = destinationViewController as? FaceViewController,
             let identifier = segue.identifier,
            let expression = emotionalfaces[identifier]{
                    FaceViewController.expression = expression
                FaceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
            }
    }
    
    
    private let emotionalfaces : Dictionary<String, FacialExpression> = [
        "sad" : FacialExpression(eyes: .closed, mouth: .frown),
        "happy" : FacialExpression(eyes: .open, mouth: .smile),
        "worried" : FacialExpression(eyes: .open, mouth : .smirk)
    
    ]
        
    

}
