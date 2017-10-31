//
//  LineSeperator.swift
//  DesignTest
//
//  Created by Ansuke on 10/30/17.
//  Copyright © 2017 AM. All rights reserved.
//

import UIKit

class LineSeperator: UIView {

    override func draw(_ rect: CGRect) {
        
        // This tag is to tell the difference between which line to draw in the country picker view.
        // The ">" or the line seperating the country picker from the phone number field
        if tag == 1 {
            
            //// Bezier Drawing for ">" symbol
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 1.25, y: 0.75))
            bezierPath.addLine(to: CGPoint(x: 8.75, y: 7))
            bezierPath.addLine(to: CGPoint(x: 1.25, y: 13.25))
            UIColor.black.setStroke()
            bezierPath.lineWidth = 0.5
            bezierPath.stroke()


        } else {
        
            //// Color Declarations
            let color = UIColor(red: 0.816, green: 0.816, blue: 0.816, alpha: 1.000)
            let color2 = UIColor(red: 0.816, green: 0.816, blue: 0.816, alpha: 1.000)
            let color3 = UIColor(red: 0.816, green: 0.816, blue: 0.816, alpha: 1.000)
            
            //// Bezier Drawing for line below country picker button 1/3
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 31, y: 0))
            bezierPath.addLine(to: CGPoint(x: self.frame.width, y: -0))
            color3.setFill()
            bezierPath.fill()
            color2.setStroke()
            bezierPath.lineWidth = 2
            bezierPath.stroke()
            
            
            //// Bezier Drawing for "v" indent below country picker button 2/3
            let bezier2Path = UIBezierPath()
            bezier2Path.move(to: CGPoint(x: 22, y: 0))
            bezier2Path.addLine(to: CGPoint(x: 26.75, y: 3.75))
            bezier2Path.addLine(to: CGPoint(x: 31.5, y: 0))
            color.setStroke()
            bezier2Path.lineWidth = 1
            bezier2Path.stroke()
            
            
            //// Bezier Drawing for the rest of the line below country picker button 3/3
            let bezier3Path = UIBezierPath()
            bezier3Path.move(to: CGPoint(x: 22, y: 0))
            bezier3Path.addLine(to: CGPoint(x: 0, y: 0))
            color3.setFill()
            bezier3Path.fill()
            color2.setStroke()
            bezier3Path.lineWidth = 2
            bezier3Path.stroke()

        }

    }

}
