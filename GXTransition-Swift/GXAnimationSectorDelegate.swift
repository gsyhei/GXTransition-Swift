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
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: -CGFloat(Double.pi/2)))
        case .left:
            toView.layer.anchorPoint = CGPoint(x: 0.0, y: 1.0)
            toView.layer.position = CGPoint(x: 0.0, y: height)
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(Double.pi/2)))
        case .right:
            toView.layer.anchorPoint = CGPoint(x: 1.0, y: 1.0)
            toView.layer.position = CGPoint(x: width, y: height)
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: -CGFloat(Double.pi/2)))
        case .bottom:
            toView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
            toView.layer.position = CGPoint(x: width, y: 0.0)
            toView.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(Double.pi/2)))
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
        let fromSnapshotView = fromView.snapshotView(afterScreenUpdates: false)!
        transitionContext.containerView.addSubview(fromSnapshotView)
        fromView.isHidden = true
        
        var transform: CGAffineTransform
        switch self.subtype {
        case .top:
            fromSnapshotView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            fromSnapshotView.layer.position = CGPoint(x: 0.0, y: 0.0)
            transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/2))
        case .left:
            fromSnapshotView.layer.anchorPoint = CGPoint(x: 0.0, y: 1.0)
            fromSnapshotView.layer.position = CGPoint(x: 0.0, y: height)
            transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        case .right:
            fromSnapshotView.layer.anchorPoint = CGPoint(x: 1.0, y: 1.0)
            fromSnapshotView.layer.position = CGPoint(x: width, y: height)
            transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/2))
        case .bottom:
            fromSnapshotView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
            fromSnapshotView.layer.position = CGPoint(x: width, y: 0.0)
            transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        }
        self.addBackgroundView(to: toView)
        self.addShadow(to: fromView)
        self.animateWithContext(transitionContext, isPresent: false, animations: {
            fromSnapshotView.layer.setAffineTransform(transform)
        }) { (finished) in
            fromView.isHidden = false
            fromSnapshotView.removeFromSuperview()
        }
    }
}
