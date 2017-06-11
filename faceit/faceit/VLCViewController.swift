//
//  VLCViewController.swift
//  faceit
//
//  Created by pokemon on 6/6/17.
//  Copyright © 2017 pokemon. All rights reserved.
//

import UIKit

class VLCViewController: UIViewController {
    
    private struct LogGlobals {
        var prefix = ""
        var instantcount = [String:Int] ()
        var lastlogtime = Date()
        var indentinterval : TimeInterval = 1
        var identationstring = "_"
    }
        private static var log = LogGlobals()
    private static func log(for className : String) -> String{
        if log.lastlogtime.timeIntervalSinceNow < -log.indentinterval {
            log.prefix += log.identationstring
            print("") }
        }
        private static func bumpinstantcount (for className : String) -> Int{
            log.instantcount[className]  = (log.instantcount[className] ?? 0) +1
            return log.instantcount[className]!
        }
        var instantcount: Int!
    private func logvcl (_ msg : String){
        let className = String(describing: type:of(self))
        if (instantcount == nil){
            instantcount = VLCViewController.bumpinstantcount(for: className)
        }
        print("\(VLCViewController.logPrefix(for: className))(\(instantcount!)) \(msg)")
        
    }
    required init? (coder aDecoder : NSCoder){
        super.init(coder : aDecoder)
        logvcl("init(coder:) - created via InterfaceBuilder ")
    }
    override init(nib N)
    
        
        

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
