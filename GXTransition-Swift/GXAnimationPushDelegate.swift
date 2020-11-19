//
//  GXAnimationPushDelegate.swift
//  GXTransitionSample
//
//  Created by Gin on 2020/11/18.
//

import UIKit

private let GX_ANIMATED_SCALE: CGFloat = 0.3

class GXAnimationPushDelegate: GXAnimationBaseDelegate {
    // MARK: - Override
    
    override func presentViewAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromView = (transitionContext.viewController(forKey: .from)?.view)!
        let toView = (transitionContext.viewController(forKey: .to)?.view)!
        transitionContext.containerView.addSubview(toView)
        
        let fromSnapshotView = fromView.snapshotView(afterScreenUpdates: false)!
        transitionContext.containerView.addSubview(fromSnapshotView)
        transitionContext.containerView.bringSubviewToFront(toView)
        fromView.isHidden = true
        
        var toFrame = toView.frame, fromFrame = fromView.frame
        switch self.subtype {
        case .top:
            toFrame.origin.y = toView.frame.height
            toView.frame = toFrame
            toFrame.origin.y = 0.0
            fromFrame.origin.y = -fromView.frame.height * GX_ANIMATED_SCALE
        case .left:
            toFrame.origin.x = toView.frame.width
            toView.frame = toFrame
            toFrame.origin.x = 0.0
            fromFrame.origin.x = -fromView.frame.width * GX_ANIMATED_SCALE
        case .right:
            toFrame.origin.x = -toView.frame.width
            toView.frame = toFrame
            toFrame.origin.x = 0.0
            fromFrame.origin.x = fromView.frame.width * GX_ANIMATED_SCALE
        case .bottom:
            toFrame.origin.y = -toView.frame.height
            toView.frame = toFrame
            toFrame.origin.y = 0.0
            fromFrame.origin.y = fromView.frame.height * GX_ANIMATED_SCALE
        }
        self.addBackgroundView(to: fromSnapshotView)
        self.addShadow(to: toView)
        self.animateWithContext(transitionContext, isPresent: true) {
            toView.frame = toFrame
            fromSnapshotView.frame = fromFrame
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

        var toFrame = toView.frame, fromFrame = fromView.frame
        switch self.subtype {
        case .top:
            toFrame.origin.y = -toView.frame.height * GX_ANIMATED_SCALE
            toView.frame = toFrame
            toFrame.origin.y = 0.0
            fromFrame.origin.y = fromView.frame.height
        case .left:
            toFrame.origin.x = -toView.frame.width * GX_ANIMATED_SCALE
            toView.frame = toFrame
            toFrame.origin.x = 0.0
            fromFrame.origin.x = fromView.frame.width
        case .right:
            toFrame.origin.x = toView.frame.width * GX_ANIMATED_SCALE
            toView.frame = toFrame
            toFrame.origin.x = 0.0
            fromFrame.origin.x = -fromView.frame.width
        case .bottom:
            toFrame.origin.y = toView.frame.height * GX_ANIMATED_SCALE
            toView.frame = toFrame
            toFrame.origin.y = 0.0
            fromFrame.origin.y = -fromView.frame.height
        }
        self.addBackgroundView(to: toView)
        self.addShadow(to: fromView)
        self.animateWithContext(transitionContext, isPresent: false, animations: {
            toView.frame = toFrame
            fromView.frame = fromFrame
        }, completion: nil)
    }
    
}
