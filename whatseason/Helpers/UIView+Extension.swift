//
//  UIView+Extension.swift
//  whatseason
//
//  Created by namdghyun on 1/9/24.
//

import UIKit

extension UIView{
    func setGradient(color1: UIColor, color2: UIColor, loc: [NSNumber], start: CGPoint, end: CGPoint){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = loc
        gradient.startPoint = start
        gradient.endPoint = end
        gradient.frame = bounds
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}
