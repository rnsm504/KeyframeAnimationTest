//
//  ViewController.swift
//  KeyframeAnimationTest
//
//  Created by msnr on 2018/04/14.
//  Copyright © 2018年 msnr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let backLayer = BackLayer()
        backLayer.frame = self.view.frame
        
        self.view.layer.addSublayer(backLayer)
        backLayer.setNeedsDisplay()

        let path = UIBezierPath()
        
        var x : CGFloat = 0
        var y : CGFloat = 0
        var r : CGFloat = 0
        var b : CGFloat = 0
        
        b = 0
        r = 0
        
        let midY = self.view.frame.midY

        var values = [CGPath]()

        //アルキメデスの螺旋
//        x = 5 * r * cos(r) + self.view.frame.midX
//        let midX = self.view.frame.midX
//        y = 5 * r * sin(r) + self.view.frame.midY
//
//
//        for _ in 0..<8000 {
//            path.move(to: CGPoint(x: x, y: y))
//
//            b = b + 1/sqrt(pow(x,2) + pow(y,2))
//            r =  CGFloat(2 * Double(b))
//            x = 5 * r * cos(r) + midX
//            y = 5 * r * sin(r) + midY
//
//            path.addLine(to: CGPoint(x: x, y: y))
//            values.append(path.cgPath)
//        }

        //sin関数

        y = self.view.frame.midY

        let cnt = (0...Int(self.view.frame.maxX))
        let divid = (2*Double.pi)/Double(self.view.frame.maxX)

        for a in cnt {
            path.move(to: CGPoint(x: x, y: y))
            x = CGFloat(a)
            y = -CGFloat(180.0 * sin(divid * Double(a))) + midY
            path.addLine(to: CGPoint(x: x, y: y))
            values.append(path.cgPath)
        }

        let anime = CAKeyframeAnimation(keyPath: "path")
        anime.values = values
        anime.duration = 5.0
        anime.isRemovedOnCompletion = false
        anime.fillMode = kCAFillModeForwards
        anime.beginTime = CACurrentMediaTime() + 2.0
        anime.repeatCount = .infinity
        
        let layer = CAShapeLayer()
        layer.frame = self.view.bounds
        layer.backgroundColor = UIColor.clear.cgColor
        layer.lineWidth = 6.0
        layer.strokeColor = UIColor.cyan.cgColor
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = self.view.bounds
        shadowLayer.shadowColor = UIColor.cyan.cgColor
        shadowLayer.shadowOffset = CGSize.zero
        shadowLayer.shadowOpacity = 1.0
        shadowLayer.lineWidth = 7.0
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        shadowLayer.insertSublayer(layer, at: 0)
        
        layer.add(anime, forKey: anime.keyPath)
        shadowLayer.add(anime, forKey: anime.keyPath)
        self.view.layer.addSublayer(shadowLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class BackLayer : CAShapeLayer {
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
        //背景
        let c = UIColor.black.cgColor
        ctx.setFillColor(c)
        ctx.fill(self.bounds)
        
        let cc = UIColor.lightGray.cgColor
        
        let line = UIBezierPath()
        line.lineWidth = 1.0
        line.move(to: CGPoint(x: 0, y: self.frame.midY))
        line.addLine(to: CGPoint(x: self.frame.maxX, y: self.frame.midY))
        line.move(to: CGPoint(x: self.frame.midX , y: 0))
        line.addLine(to: CGPoint(x: self.frame.midX, y: self.frame.maxY))
        line.close()
        ctx.addPath(line.cgPath)
        ctx.setStrokeColor(cc)
        ctx.strokePath()
    }
    
   
}



