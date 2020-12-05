//
//  GXAnimationCubeDelegate.swift
//  GXTransitionSample
//
//  Created by Gin on 2020/12/5.
//

import UIKit

class GXAnimationCubeDelegate: GXAnimationBaseDelegate {
    // MARK: - Override
    
    override func presentViewAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromView = (transitionContext.viewController(forKey: .from)?.view)!
        let toView = (transitionContext.viewController(forKey: .to)?.view)!
        transitionContext.containerView.addSubview(toView)
        
        let width = transitionContext.containerView.frame.width
        let height = transitionContext.containerView.frame.height
        let fromSnapshotView = fromView.snapshotView(afterScreenUpdates: false)!
        transitionContext.containerView.addSubview(fromSnapshotView)
        transitionContext.containerView.bringSubviewToFront(toView)
        fromView.isHidden = true
        
        var transform3D: CATransform3D = CATransform3DIdentity
        switch self.subtype {
        case .top:
            var toTransform3D = CATransform3DMakeTranslation(0, height * 0.5, -height * 0.5)
            toTransform3D = CATransform3DRotate(toTransform3D, -CGFloat(Float.pi/2), 1.0, 0, 0)
            toView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DMakeTranslation(0, -height * 0.5, 0)
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi/2), 1.0, 0, 0)
        case .left:
            var toTransform3D = CATransform3DMakeTranslation(width * 0.5, 0, -width * 0.5)
            toTransform3D = CATransform3DRotate(toTransform3D, CGFloat(Float.pi/2), 0, 1.0, 0)
            toView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DMakeTranslation(-width * 0.5, 0, 0)
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi/2), 0, 1.0, 0)
        case .right:
            var toTransform3D = CATransform3DMakeTranslation(-width * 0.5, 0, -width * 0.5)
            toTransform3D = CATransform3DRotate(toTransform3D, -CGFloat(Float.pi/2), 0, 1.0, 0)
            toView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DMakeTranslation(width * 0.5, 0, 0)
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi/2), 0, 1.0, 0)
        case .bottom:
            var toTransform3D = CATransform3DMakeTranslation(0, -height * 0.5, -height * 0.5)
            toTransform3D = CATransform3DRotate(toTransform3D, CGFloat(Float.pi/2), 1.0, 0, 0)
            toView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DMakeTranslation(0, height * 0.5, 0)
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi/2), 1.0, 0, 0)
        }
        self.addBackgroundView(to: fromView)
        self.addShadow(to: toView)
        self.animateWithContext(transitionContext, isPresent: true) {
            transitionContext.containerView.layer.sublayerTransform = transform3D
        } completion: { (finished) in
            fromView.isHidden = false
            fromSnapshotView.removeFromSuperview()
            transitionContext.containerView.layer.sublayerTransform = CATransform3DIdentity
            toView.layer.transform = CATransform3DIdentity
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
        let toSnapshotView = toView.snapshotView(afterScreenUpdates: false)!
        transitionContext.containerView.addSubview(toSnapshotView)
        toView.isHidden = true
        
        var transform3D: CATransform3D = CATransform3DIdentity
        switch self.subtype {
        case .top:
            var toTransform3D = CATransform3DMakeTranslation(0, -height * 0.5, -height * 0.5)
            toTransform3D = CATransform3DRotate(toTransform3D, CGFloat(Float.pi/2), 1.0, 0, 0)
            toSnapshotView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DMakeTranslation(0, height * 0.5, 0)
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi/2), 1.0, 0, 0)
        case .left:
            var toTransform3D = CATransform3DMakeTranslation(-width * 0.5, 0, -width * 0.5)
            toTransform3D = CATransform3DRotate(toTransform3D, -CGFloat(Float.pi/2), 0, 1.0, 0)
            toSnapshotView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DMakeTranslation(width * 0.5, 0, 0)
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi/2), 0, 1.0, 0)
        case .right:
            var toTransform3D = CATransform3DMakeTranslation(width * 0.5, 0, -width * 0.5)
            toTransform3D = CATransform3DRotate(toTransform3D, CGFloat(Float.pi/2), 0, 1.0, 0)
            toSnapshotView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DMakeTranslation(-width * 0.5, 0, 0)
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi/2), 0, 1.0, 0)
        case .bottom:
            var toTransform3D = CATransform3DMakeTranslation(0, height * 0.5, -height * 0.5)
            toTransform3D = CATransform3DRotate(toTransform3D, -CGFloat(Float.pi/2), 1.0, 0, 0)
            toSnapshotView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DMakeTranslation(0, -height * 0.5, 0)
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi/2), 1.0, 0, 0)
        }
        self.addBackgroundView(to: toSnapshotView)
        self.addShadow(to: fromView)
        self.animateWithContext(transitionContext, isPresent: false) {
            transitionContext.containerView.layer.sublayerTransform = transform3D
        } completion: { (finished) in
            toView.isHidden = false
            toSnapshotView.removeFromSuperview()
            transitionContext.containerView.layer.sublayerTransform = CATransform3DIdentity
        }
    }
    
}
