//
//  LoadingIndicatorView.swift
//  Animation
//
//  Created by Yaroslav on 10/3/19.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    
    var strokeWidth:CGFloat = 10 {
        didSet {
            setup()
        }
    }
    var innerCircleWidth:CGFloat = 2 {
        didSet {
            setup()
        }
    }
    var externCircleWidth:CGFloat = 2 {
        didSet {
            setup()
        }
    }
    
    
    
    let animator = ActivityIndicatorAnimation()
    
    let marginOrPadding: CGFloat = 20
    
    //MARK: Layers
    private let indicator = CAShapeLayer()
    private let innerCircle = CAShapeLayer()
    private let externCircle = CAShapeLayer()

    private let maskIndicator = CAShapeLayer()
    private let innerCircleMask = CAShapeLayer()
    private let externCircleMask = CAShapeLayer()
    
    private let gradient = CAGradientLayer()
    private let gradientInner = CAGradientLayer()
    private let gradientExtern = CAGradientLayer()
    
    //MARK: Colors
    
    var gradientColors = [ UIColor(red:0.22, green:0.93, blue:0.73, alpha:1.0).cgColor,
                           UIColor(red:0.33, green:0.81, blue:0.78, alpha:1.0).cgColor,
                           UIColor(red:0.45, green:0.69, blue:0.83, alpha:0.7).cgColor]
    var gradientInnerColors = [ UIColor(red:0.22, green:0.93, blue:0.73, alpha:1.0).cgColor,
                                UIColor(red:0.33, green:0.81, blue:0.78, alpha:1.0).cgColor,
                                UIColor(red:0.45, green:0.69, blue:0.83, alpha:0.7).cgColor]
    var gradientExternColors = [ UIColor(red:0.22, green:0.93, blue:0.73, alpha:1.0).cgColor,
                                 UIColor(red:0.33, green:0.81, blue:0.78, alpha:1.0).cgColor,
                                 UIColor(red:0.45, green:0.69, blue:0.83, alpha:0.7).cgColor]
    
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        indicator.fillColor = nil
        indicator.lineWidth = strokeWidth
        indicator.lineCap = .round
        indicator.strokeStart = 0.0
        indicator.strokeEnd = 0.0
        
        innerCircle.fillColor = nil
        innerCircle.lineWidth = innerCircleWidth
        innerCircle.lineCap = .round
        innerCircle.strokeStart = 0.0
        innerCircle.strokeEnd = 0.0
        
        externCircle.fillColor = nil
        externCircle.lineWidth = externCircleWidth
        externCircle.lineCap = .round
        externCircle.strokeStart = 0.0
        externCircle.strokeEnd = 0.0
        
        layer.addSublayer(gradient)
        layer.addSublayer(indicator)
        layer.addSublayer(innerCircle)
        layer.addSublayer(externCircle)
    }
    
    func startAnimate() {
        setup()
        
        indicator.add(animator.rotationAnimation(with: 5), forKey: nil)
        innerCircle.add(animator.rotationAnimation(with: 10), forKey: nil)
        externCircle.add(animator.rotationAnimation(with: 7), forKey: nil)
        
        gradient.add(animator.rotationAnimationGradient(with: 5), forKey: nil)
        gradientInner.add(animator.rotationAnimationGradient(with: 9), forKey: nil)
        gradientExtern.add(animator.rotationAnimationGradient(with: 7), forKey: nil)
        
        maskIndicator.add(animator.springAnimation(with: 3.5), forKey: nil)
        innerCircleMask.add(animator.springAnimation(with: 4), forKey: nil)
        externCircleMask.add(animator.springAnimation(with: 3), forKey: nil)
    }
    
    func stopAnimation() {
        indicator.removeAllAnimations()
        innerCircle.removeAllAnimations()
        externCircle.removeAllAnimations()
        
        gradient.removeAllAnimations()
        gradientInner.removeAllAnimations()
        gradientExtern.removeAllAnimations()
        
        maskIndicator.removeAllAnimations()
        innerCircleMask.removeAllAnimations()
        externCircleMask.removeAllAnimations()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.colors = gradientColors
        gradient.frame = bounds
        
        gradientInner.startPoint = .zero
        gradientInner.endPoint = CGPoint(x: 1, y: 0)
        gradientInner.colors = gradientInnerColors
        gradientInner.frame = bounds
        
        gradientExtern.startPoint = .zero
        gradientExtern.endPoint = CGPoint(x: 1, y: 0)
        gradientExtern.colors = gradientExternColors
        gradientExtern.frame = bounds
        
        indicator.frame = bounds
        indicator.addSublayer(gradient)
        
        innerCircle.frame = bounds
        innerCircle.addSublayer(gradientInner)
        
        externCircle.frame = bounds
        externCircle.addSublayer(gradientExtern)
        
        let diameter = (bounds.size.min - indicator.lineWidth) - 20
        let mainCirclePath = UIBezierPath(arcCenter: bounds.center, radius: diameter / 2, startAngle: 0, endAngle: (2 * CGFloat.pi), clockwise: true)
        
        maskIndicator.path = mainCirclePath.cgPath
        maskIndicator.fillColor = UIColor.clear.cgColor
        maskIndicator.strokeColor = UIColor.black.cgColor
        maskIndicator.lineWidth = strokeWidth
        maskIndicator.lineCap = .round
        
        indicator.mask = maskIndicator
        
        let innerCirclePath = UIBezierPath(arcCenter: bounds.center, radius: (diameter - marginOrPadding) / 2 , startAngle: (.pi / 2), endAngle:(.pi / 2) + (2 * .pi), clockwise: true)
        innerCircleMask.path = innerCirclePath.cgPath
        innerCircleMask.fillColor = UIColor.clear.cgColor
        innerCircleMask.strokeColor = UIColor.black.cgColor
        innerCircleMask.lineWidth = innerCircleWidth
        innerCircleMask.lineCap = .round
        innerCircle.mask = innerCircleMask
        
        let externCirclePath = UIBezierPath(arcCenter: bounds.center, radius: (diameter + marginOrPadding) / 2, startAngle: (.pi / 4), endAngle: ((.pi / 4) + (2 * .pi)), clockwise: true)
        externCircleMask.path = externCirclePath.cgPath
        externCircleMask.fillColor = UIColor.clear.cgColor
        externCircleMask.strokeColor = UIColor.black.cgColor
        externCircleMask.lineWidth = externCircleWidth
        externCircleMask.lineCap = .round
        externCircle.mask = externCircleMask
    }
}

//MARK: extensions

extension CGSize {
    var min: CGFloat {
        return CGFloat.minimum(width, height)
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

extension CAPropertyAnimation {
    enum Key: String {
        var path: String {
            return rawValue
        }
        case strokeStart = "strokeStart"
        case strokeEnd = "strokeEnd"
        case strokeColor = "strokeColor"
        case rotationZ = "transform.rotation.z"
        case scale = "transform.scale"
    }
    convenience init(key: Key) {
        self.init(keyPath: key.path)
    }
}
