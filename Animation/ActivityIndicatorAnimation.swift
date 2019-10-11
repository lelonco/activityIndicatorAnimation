//
//  ActivityIndicatorAnimation.swift
//  Animation
//
//  Created by Yaroslav on 10/8/19.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit

class ActivityIndicatorAnimation {
    
    
    
    func rotationAnimation(with duration: Int) -> CABasicAnimation {
        let animation = CABasicAnimation(key: .rotationZ)
        animation.duration = CFTimeInterval(duration)
        animation.fromValue = 0
        animation.toValue = (2 * Double.pi)
        animation.repeatCount = .infinity
        return animation
    }
    
    func rotationAnimationGradient(with duration: Int) -> CABasicAnimation {
        let animation = CABasicAnimation(key: .rotationZ)
        animation.duration = CFTimeInterval(duration)
        animation.fromValue = 0
        animation.toValue = (2 * Double.pi)
        animation.repeatCount = .infinity
        
        return animation
    }
    
    func springAnimation(with duration: Double) -> CAAnimationGroup {
        let durationAnim = duration - 1
        let animation = CAAnimationGroup()
        animation.duration = duration
        animation.animations = [strokeStartAnimation(with: durationAnim, startTime: 1),
                                strokeEndAnimation(with: durationAnim),
                                strokeCatchAnimation(with: 1, startTime: durationAnim),
                                strokeFreezeAnimation(with: 1, startTime: duration)]
        animation.repeatCount = .infinity
        
        return animation
    }
    
    func strokeStartAnimation(with duration: Double, startTime: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeStart)
        animation.beginTime = startTime
        animation.duration = duration - startTime
        animation.fromValue = 0
        animation.toValue = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
    func strokeEndAnimation(with duration: Double) -> CABasicAnimation {
        let animationMove = CABasicAnimation(key: .strokeEnd)
        animationMove.duration = duration
        animationMove.fromValue = 0
        animationMove.toValue = 1
        animationMove.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animationMove
    }
    
    func strokeCatchAnimation(with duration: Double, startTime: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeStart)
        animation.beginTime = startTime
        animation.duration = duration
        animation.fromValue = 0.5
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
    func strokeFreezeAnimation(with duration: Double, startTime: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeEnd)
        animation.beginTime = startTime
        animation.duration = duration
        animation.fromValue = 1
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
}
