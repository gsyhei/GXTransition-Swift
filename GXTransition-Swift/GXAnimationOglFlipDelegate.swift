//
//  GXAnimationOglFlipDelegate.swift
//  GXTransitionSample
//
//  Created by Gin on 2020/12/6.
//

import UIKit

class GXAnimationOglFlipDelegate: GXAnimationBaseDelegate {
    // MARK: - Override
    
    override func presentViewAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromView = (transitionContext.viewController(forKey: .from)?.view)!
        let toView = (transitionContext.viewController(forKey: .to)?.view)!
        transitionContext.containerView.addSubview(toView)

        let fromSnapshotView = fromView.snapshotView(afterScreenUpdates: false)!
        transitionContext.containerView.addSubview(fromSnapshotView)
        transitionContext.containerView.bringSubviewToFront(toView)
        fromView.isHidden = true
        
        var transform3D = CATransform3DIdentity
        switch self.subtype {
        case .top:
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0.1);
            fromSnapshotView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0)
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi), 1.0, 0, 0)
            toView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D.m34 = 1.0 / -500;
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi), 1.0, 0, 0)
        case .left:
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0.1);
            fromSnapshotView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0)
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi), 0, 1.0, 0)
            toView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D.m34 = 1.0 / -500;
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi), 0, 1.0, 0)
        case .right:
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0.1);
            fromSnapshotView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0)
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi), 0, 1.0, 0)
            toView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D.m34 = 1.0 / -500;
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi), 0, 1.0, 0)
        case .bottom:
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0.1);
            fromSnapshotView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0)
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi), 1.0, 0, 0)
            toView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D.m34 = 1.0 / -500;
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi), 1.0, 0, 0)
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
        
        let toSnapshotView = toView.snapshotView(afterScreenUpdates: false)!
        transitionContext.containerView.addSubview(toSnapshotView)
        toView.isHidden = true
        
        var transform3D = CATransform3DIdentity
        switch self.subtype {
        case .top:
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0.1);
            fromView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0)
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi), 1.0, 0, 0)
            toSnapshotView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D.m34 = 1.0 / -500;
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi), 1.0, 0, 0)
        case .left:
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0.1);
            fromView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0)
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi), 0, 1.0, 0)
            toSnapshotView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D.m34 = 1.0 / -500;
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi), 0, 1.0, 0)
        case .right:
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0.1);
            fromView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0)
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi), 0, 1.0, 0)
            toSnapshotView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D.m34 = 1.0 / -500;
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi), 0, 1.0, 0)
        case .bottom:
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0.1);
            fromView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D = CATransform3DTranslate(transform3D, 0, 0, 0)
            transform3D = CATransform3DRotate(transform3D, -CGFloat(Float.pi), 1.0, 0, 0)
            toSnapshotView.layer.transform = transform3D
            transform3D = CATransform3DIdentity
            transform3D.m34 = 1.0 / -500;
            transform3D = CATransform3DRotate(transform3D, CGFloat(Float.pi), 1.0, 0, 0)
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
