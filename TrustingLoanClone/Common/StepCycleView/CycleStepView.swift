//
//  CycleStepView.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 11/1/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import UIKit

@IBDesignable
class CycleStepView: UIView {

    @IBInspectable var title: String = "1"
    @IBInspectable var done: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), radius: bounds.width/2 - 1, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        path.lineWidth = 1
        UIColor.blue.setStroke()
        if done {
            UIColor.blue.setFill()
        } else {
            UIColor.clear.setFill()
        }
        path.fill()
        path.stroke()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let colorTitle = done ? UIColor.white : UIColor.blue
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: colorTitle, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let fontHeight = UIFont.systemFont(ofSize: 22).lineHeight
        attributedString.draw(in: CGRect(x: 0, y: bounds.height/2 - fontHeight/2, width: bounds.width, height: fontHeight))
    }

}
