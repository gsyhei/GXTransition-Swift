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
            var fromTransform3D = CATransform3DIdentity
            fromTransform3D = CATransform3DTranslate(fromTransform3D, 0, 0, height * 0.5)
            fromTransform3D = CATransform3DRotate(fromTransform3D, 0, 0, 0, 0)
            fromSnapshotView.layer.transform = fromTransform3D
            var toTransform3D = CATransform3DTranslate(transform3D, 0, height * 0.5, 0)
            toTransform3D = CATransform3DRotate(toTransform3D, -CGFloat(Float.pi/2), 1.0, 0, 0)
            toView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transform3D = CATransform3DTranslate(transform3D, 0, 0, -height * 0.5)
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi/2), 1.0, 0, 0)
        case .left:
            var fromTransform3D = CATransform3DIdentity
            fromTransform3D = CATransform3DTranslate(fromTransform3D, 0, 0, width * 0.5)
            fromTransform3D = CATransform3DRotate(fromTransform3D, 0, 0, 0, 0)
            fromSnapshotView.layer.transform = fromTransform3D
            var toTransform3D = CATransform3DIdentity
            toTransform3D = CATransform3DTranslate(toTransform3D, width * 0.5, 0, 0)
            toTransform3D = CATransform3DRotate(toTransform3D, CGFloat(Float.pi/2), 0, 1.0, 0)
            toView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transform3D = CATransform3DTranslate(transform3D, 0, 0, -width * 0.5)
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi/2), 0, 1.0, 0)
        case .right:
            var fromTransform3D = CATransform3DIdentity
            fromTransform3D = CATransform3DTranslate(fromTransform3D, 0, 0, width * 0.5)
            fromTransform3D = CATransform3DRotate(fromTransform3D, 0, 0, 0, 0)
            fromSnapshotView.layer.transform = fromTransform3D
            var toTransform3D = CATransform3DTranslate(transform3D, -width * 0.5, 0, 0)
            toTransform3D = CATransform3DRotate(toTransform3D, -CGFloat(Float.pi/2), 0, 1.0, 0)
            toView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transform3D = CATransform3DTranslate(transform3D, 0, 0, -width * 0.5)
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi/2), 0, 1.0, 0)
        case .bottom:
            var fromTransform3D = CATransform3DIdentity
            fromTransform3D = CATransform3DTranslate(fromTransform3D, 0, 0, height * 0.5)
            fromTransform3D = CATransform3DRotate(fromTransform3D, 0, 0, 0, 0)
            fromSnapshotView.layer.transform = fromTransform3D
            var toTransform3D = CATransform3DTranslate(transform3D, 0, -height * 0.5, 0)
            toTransform3D = CATransform3DRotate(toTransform3D, CGFloat(Float.pi/2), 1.0, 0, 0)
            toView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transform3D = CATransform3DTranslate(transform3D, 0, 0, -height * 0.5)
            transitionContext.containerView.layer.sublayerTransform = transform3D
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
            var fromTransform3D = CATransform3DIdentity
            fromTransform3D = CATransform3DTranslate(fromTransform3D, 0, 0, height * 0.5)
            fromTransform3D = CATransform3DRotate(fromTransform3D, 0, 0, 0, 0)
            fromView.layer.transform = fromTransform3D
            var toTransform3D = CATransform3DTranslate(transform3D, 0, -height * 0.5, 0)
            toTransform3D = CATransform3DRotate(toTransform3D, CGFloat(Float.pi/2), 1.0, 0, 0)
            toSnapshotView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transform3D = CATransform3DTranslate(transform3D, 0, 0, -height * 0.5)
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi/2), 1.0, 0, 0)
        case .left:
            var fromTransform3D = CATransform3DIdentity
            fromTransform3D = CATransform3DTranslate(fromTransform3D, 0, 0, width * 0.5)
            fromTransform3D = CATransform3DRotate(fromTransform3D, 0, 0, 0, 0)
            fromView.layer.transform = fromTransform3D
            var toTransform3D = CATransform3DTranslate(transform3D, -width * 0.5, 0, 0)
            toTransform3D = CATransform3DRotate(toTransform3D, -CGFloat(Float.pi/2), 0, 1.0, 0)
            toSnapshotView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transform3D = CATransform3DTranslate(transform3D, 0, 0, -width * 0.5)
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi/2), 0, 1.0, 0)
        case .right:
            var fromTransform3D = CATransform3DIdentity
            fromTransform3D = CATransform3DTranslate(fromTransform3D, 0, 0, width * 0.5)
            fromTransform3D = CATransform3DRotate(fromTransform3D, 0, 0, 0, 0)
            fromView.layer.transform = fromTransform3D
            var toTransform3D = CATransform3DIdentity
            toTransform3D = CATransform3DTranslate(toTransform3D, width * 0.5, 0, 0)
            toTransform3D = CATransform3DRotate(toTransform3D, CGFloat(Float.pi/2), 0, 1.0, 0)
            toSnapshotView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transform3D = CATransform3DTranslate(transform3D, 0, 0, -width * 0.5)
            transitionContext.containerView.layer.sublayerTransform = transform3D
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi/2), 0, 1.0, 0)
        case .bottom:
            var fromTransform3D = CATransform3DIdentity
            fromTransform3D = CATransform3DTranslate(fromTransform3D, 0, 0, height * 0.5)
            fromTransform3D = CATransform3DRotate(fromTransform3D, 0, 0, 0, 0)
            fromView.layer.transform = fromTransform3D
            var toTransform3D = CATransform3DTranslate(transform3D, 0, height * 0.5, 0)
            toTransform3D = CATransform3DRotate(toTransform3D, -CGFloat(Float.pi/2), 1.0, 0, 0)
            toSnapshotView.layer.transform = toTransform3D
            transform3D.m34 = 1.0 / -1200
            transform3D = CATransform3DTranslate(transform3D, 0, 0, -height * 0.5)
            transitionContext.containerView.layer.sublayerTransform = transform3D
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
