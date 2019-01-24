//
//  ViewController.swift
//  GraphView
//
//  Created by Hasan Tahir on 22/01/2019.
//  Copyright © 2019 Hasan Tahir. All rights reserved.
//

import UIKit
import SwiftyWave
class ViewController: UIViewController {

    enum Direction{
        case Up
        case Down
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let wave = SwiftyWaveView(frame: CGRect(x: 50, y: 100, width: 300, height: 300))
        //let line = LineView(frame: self.view.frame)
        //self.view.addSubview(line)
        let startingPoint : CGPoint =  CGPoint (x: 0, y: UIScreen.main.bounds.midY)
        animateLine(StartingPoint: startingPoint)
       
        
    
        //self.view.addSubview(wave)
        //wave.start()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resjjkklources that can be recreated.
    }
    weak var shapeLayer: CAShapeLayer?
    
    func animateLine(StartingPoint startPoint : CGPoint) {
        // remove old shape layer if any
        
        self.shapeLayer?.removeFromSuperlayer()
        
        // create whatever path you want
        let path = UIBezierPath()
        path.move(to: startPoint)
        var currentX1 : CGFloat = startPoint.x
        var currentX2 : CGFloat = startPoint.x
        var currentX : CGFloat = startPoint.x
        
        var currentY : CGFloat = startPoint.y
        var currentY1 : CGFloat = startPoint.y
        var currentY2 : CGFloat = startPoint.y
        
        var currentDirection : Direction = .Up
        while (currentX < UIScreen.main.bounds.maxX) {
            currentX += CGFloat(arc4random()%30 + 1)
            
            currentX1 = currentX - CGFloat(arc4random()%10 + 1)
            currentX2 = currentX - CGFloat(arc4random()%30 + 1)
            
            if currentDirection == .Up{
                currentY1 = startPoint.y + CGFloat(arc4random()%50 + 1)
                currentY2 = startPoint.y + CGFloat(arc4random()%50 + 1)
                currentDirection = .Down
            }
            else{
                //currentY = startPoint.y - CGFloat(arc4random()%30 + 1)
                currentY1 = startPoint.y - CGFloat(arc4random()%50 + 1)
                currentY2 = startPoint.y - CGFloat(arc4random()%50 + 1)
                currentDirection = .Up
            }
        //    path.addLine(to: CGPoint(x: currentX, y: currentY))
          path.addCurve(to: CGPoint(x: currentX, y: startPoint.y), controlPoint1: CGPoint(x: currentX1, y: currentY1), controlPoint2: CGPoint(x: currentX2, y: currentY1))
        }
        
        //path.addLine(to: CGPoint(x: 200, y: 50))
       // path.addLine(to: CGPoint(x: 220, y: 240))
        
        // create shape layer for that path
        //path.addCurve(to: CGPoint(x: 50, y: 350), controlPoint1: CGPoint(x: 15, y: 450), controlPoint2: CGPoint(x: 35, y: 450))
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.path = path.cgPath
        
        // animate it
        
        view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 5
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        // save shape layer
        
        self.shapeLayer = shapeLayer
    }
}

class LineView : UIView{
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        
        aPath.move(to: CGPoint(x:30, y:100))
        
        aPath.addLine(to: CGPoint(x:150, y:300))
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        
        //If you want to stroke it with a red color
        UIColor.red.set()
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()
    }
}
class SineView: UIView{
    let graphWidth: CGFloat = 0.8  // Graph is 80% of the width of the view
    let amplitude: CGFloat = 0.3   // Amplitude of sine wave is 30% of view height
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let origin = CGPoint(x: width * (1 - graphWidth) / 2, y: height * 0.50)
        
        let path = UIBezierPath()
        path.move(to: origin)
        
        for angle in stride(from: 5.0, through: 360.0, by: 5.0) {
            let x = origin.x + CGFloat(angle/360.0) * width * graphWidth
            let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi)) * height * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        UIColor.black.setStroke()
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.path = path.cgPath
        //let sineView = SineView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    }
}
