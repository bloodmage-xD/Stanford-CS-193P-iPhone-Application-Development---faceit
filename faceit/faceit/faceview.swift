//
//  faceview.swift
//  faceit
//
//  Created by pokemon on 5/30/17.
//  Copyright © 2017 pokemon. All rights reserved.
//

import UIKit

@IBDesignable
class faceview: UIView {

    @IBInspectable
    var scale : CGFloat = 0.9{didSet{setNeedsDisplay()}}
        
    
    @IBInspectable
    var eyesOpen : Bool = true {didSet{setNeedsDisplay()}}
    @IBInspectable
    var mouthcurvature : Double = -0.5{didSet{setNeedsDisplay()}}
    @IBInspectable
    var linewidth : CGFloat = 5.0{didSet{setNeedsDisplay()}}
    @IBInspectable
    var color : UIColor = UIColor.blue{didSet{setNeedsDisplay()}}
    func changescale(byReactingTo pinchRecognizer :UIPinchGestureRecognizer){
        switch pinchRecognizer.state{
        case .changed, .ended:
            scale += pinchRecognizer.scale
            pinchRecognizer.scale = 1.0
        default:
            break
        }
    }
    
    private func pathtoskull() -> UIBezierPath{
        let path = UIBezierPath(arcCenter: skullcenter, radius: skullradius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = linewidth
        return path
    }
    
    private var skullradius: CGFloat {
        return min(bounds.height, bounds.width) / 2 * scale
    }
    
    private var skullcenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private enum Eye {
        case left
        case right
    }
    private func pathtoeye(_ eye: Eye) -> UIBezierPath {
        
        func centerofeye(_ eye: Eye) -> CGPoint {
            let eyeOffset = skullradius / Ratio.skullradiustoeyeoffset
            var eyeCenter = skullcenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            return eyeCenter
        }
        
        
        let eyeRadius = skullradius / Ratio.skullradiustoeyeradius
        let eyeCenter = centerofeye(eye)
        let path: UIBezierPath
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        }
        path.lineWidth = linewidth
        return path
    }
    private func pathformouth() -> UIBezierPath {
        let mouthWidth = skullradius / Ratio.skullradiustomouthwidth
        let mouthHeight = skullradius / Ratio.skullradiustomouthheight
        let mouthOffset = skullradius / Ratio.skullradiustomouthoffset
        
        let mouthOrigin = CGPoint(x: skullcenter.x - mouthWidth/2, y: skullcenter.y + mouthOffset)
        let mouthSize = CGSize(width: mouthWidth, height: mouthHeight)
        let mouthRect = CGRect(origin: mouthOrigin, size: mouthSize)
        
        let smileOffset = CGFloat(max(-1, min(mouthcurvature, 1))) * mouthRect.height
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3, y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3, y: end.y + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = linewidth
        return path
    }
      override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.blue.set()
        pathtoskull().stroke()
        pathtoeye(.left).stroke()
        pathtoeye(.right).stroke()
        pathformouth().stroke()
    }
    private struct Ratio{
        static let skullradiustoeyeoffset : CGFloat = 3
        static let skullradiustoeyeradius : CGFloat = 10
        static let skullradiustomouthwidth : CGFloat = 1
        static let skullradiustomouthheight: CGFloat = 3
        static let skullradiustomouthoffset : CGFloat = 3
    }

}
