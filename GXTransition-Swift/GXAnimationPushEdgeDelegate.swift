//
//  GXAnimationPushEdgeDelegate.swift
//  GXTransitionSample
//
//  Created by Gin on 2020/12/4.
//

import UIKit

private let GX_ANIMATED_SCALE: CGFloat = 0.92

class GXAnimationPushEdgeDelegate: GXAnimationBaseDelegate {
    // MARK: - Override
    
    override func presentViewAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromView = (transitionContext.viewController(forKey: .from)?.view)!
        let toView = (transitionContext.viewController(forKey: .to)?.view)!
        transitionContext.containerView.addSubview(toView)
        
        let fromSnapshotView = fromView.snapshotView(afterScreenUpdates: false)!
        transitionContext.containerView.addSubview(fromSnapshotView)
        transitionContext.containerView.bringSubviewToFront(toView)
        fromView.isHidden = true
        
        var toFrame = toView.frame
        switch self.subtype {
        case .top:
            toFrame.origin.y = toView.frame.height
            toView.frame = toFrame
            toFrame.origin.y = 0.0
        case .left:
            toFrame.origin.x = toView.frame.width
            toView.frame = toFrame
            toFrame.origin.x = 0.0
        case .right:
            toFrame.origin.x = -toView.frame.width
            toView.frame = toFrame
            toFrame.origin.x = 0.0
        case .bottom:
            toFrame.origin.y = -toView.frame.height
            toView.frame = toFrame
            toFrame.origin.y = 0.0
        }
        self.addBackgroundView(to: fromSnapshotView)
        self.addShadow(to: toView)
        self.animateWithContext(transitionContext, isPresent: true) {
            toView.frame = toFrame
            fromSnapshotView.transform = CGAffineTransform(scaleX: GX_ANIMATED_SCALE, y: GX_ANIMATED_SCALE)
        } completion: { (finished) in
            fromView.isHidden = false
            fromSnapshotView.removeFromSuperview()
        }
    }
    
    override func dismissViewAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromView = (transitionContext.viewController(forKey: .from)?.view)!
        let toView = (transitionContext.viewController(forKey: .to)?.view)!
        if self.isNavPush {
            transitionContext.containerView.addSubview(toView)
            transitionContext.containerView.bringSubviewToFront(fromView)
        }

        toView.transform = CGAffineTransform(scaleX: GX_ANIMATED_SCALE, y: GX_ANIMATED_SCALE)
        var fromFrame = fromView.frame
        switch self.subtype {
        case .top:
            fromFrame.origin.y = fromView.frame.height
        case .left:
            fromFrame.origin.x = fromView.frame.width
        case .right:
            fromFrame.origin.x = -fromView.frame.width
        case .bottom:
            fromFrame.origin.y = -fromView.frame.height
        }
        self.addBackgroundView(to: toView)
        self.addShadow(to: fromView)
        self.animateWithContext(transitionContext, isPresent: false, animations: {
            fromView.frame = fromFrame
            toView.transform = .identity
        }, completion: nil)
    }
    
}
