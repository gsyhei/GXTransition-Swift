//
//  GXAnimationSectorDelegate.swift
//  GXTransitionSample
//
//  Created by Gin on 2020/12/5.
//

import UIKit

class GXAnimationSectorDelegate: GXAnimationBaseDelegate {
    // MARK: - Override
    
    override func presentViewAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromView = (transitionContext.viewController(forKey: .from)?.view)!
        let toView = (transitionContext.viewController(forKey: .to)?.view)!
        transitionContext.containerView.addSubview(toView)
        
        let width = transitionContext.containerView.frame.width
        let height = transitionContext.containerView.frame.height

        switch self.subtype {
        case .top:
            toView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            toView.layer.position = CGPoint(x: 0.0, y: 0.0)
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: -CGFloat(Float.pi/2)))
        case .left:
            toView.layer.anchorPoint = CGPoint(x: 0.0, y: 1.0)
            toView.layer.position = CGPoint(x: 0.0, y: height)
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(Float.pi/2)))
        case .right:
            toView.layer.anchorPoint = CGPoint(x: 1.0, y: 1.0)
            toView.layer.position = CGPoint(x: width, y: height)
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: -CGFloat(Float.pi/2)))
        case .bottom:
            toView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
            toView.layer.position = CGPoint(x: width, y: 0.0)
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(Float.pi/2)))
        }
        self.addBackgroundView(to: fromView)
        self.addShadow(to: toView)
        self.animateWithContext(transitionContext, isPresent: true) {
            toView.layer.setAffineTransform(.identity)
        } completion: { (finished) in
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            toView.layer.position = CGPoint(x: width * 0.5, y: height * 0.5)
        }
    }
    
    override func dismissViewAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromView = (transitionContext.viewController(forKey: .from)?.view)!
        let toView = (transitionContext.viewController(forKey: .to)?.view)!
        if self.isNavPush {
            transitionContext.containerView.addSubview(toView)
            transitionContext.containerView.bringSubviewToFront(fromView)
        }

        let width = transitionContext.containerView.frame.width
        let height = transitionContext.containerView.frame.height

        var transform: CGAffineTransform
        switch self.subtype {
        case .top:
            fromView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            fromView.layer.position = CGPoint(x: 0.0, y: 0.0)
            transform = CGAffineTransform(rotationAngle: -CGFloat(Float.pi/2))
        case .left:
            fromView.layer.anchorPoint = CGPoint(x: 0.0, y: 1.0)
            fromView.layer.position = CGPoint(x: 0.0, y: height)
            transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi/2))
        case .right:
            fromView.layer.anchorPoint = CGPoint(x: 1.0, y: 1.0)
            fromView.layer.position = CGPoint(x: width, y: height)
            transform = CGAffineTransform(rotationAngle: -CGFloat(Float.pi/2))
        case .bottom:
            fromView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
            fromView.layer.position = CGPoint(x: width, y: 0.0)
            transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi/2))
        }
        self.addBackgroundView(to: toView)
        self.addShadow(to: fromView)
        self.animateWithContext(transitionContext, isPresent: false, animations: {
            fromView.layer.setAffineTransform(transform)
        }) { (finished) in
            fromView.isHidden = false
            fromView.layer.setAffineTransform(.identity)
        }
    }
    
}
