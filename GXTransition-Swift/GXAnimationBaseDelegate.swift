//
//  GXAnimationBaseDelegate.swift
//  GXTransitionSample
//
//  Created by Gin on 2020/11/18.
//

import UIKit

/// 转场动画方向
public enum GXAnimationSubtype: Int {
    case top    = 0
    case left   = 1
    case right  = 2
    case bottom = 3
}

public class GXAnimationBaseDelegate: NSObject, UIGestureRecognizerDelegate {
    /// 目标视图控制器
    weak var presentingViewController: UIViewController!
    /// 转场动画方向
    var subtype: GXAnimationSubtype = .left
    /// 是否为push方式
    var isNavPush: Bool = false
    /// 是否打开手势返回
    var interacting: Bool = false
    /// 是否为present
    var isPresentAnimationing: Bool = false
    /// 交互对象
    var interactivePopTransition: UIPercentDrivenInteractiveTransition?
    /// 阴影视图
    weak var shadowSuperView: UIView?
    /// 半透明背景
    lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black
        view.alpha = 0.0
        return view
    }()
    
    /// 配置转场效果
    /// - Parameters:
    ///   - presentingVC:
    ///   - subtype: 目标视图控制器
    ///   - isPush: 是否为push方式
    ///   - interacted: 是否打开手势返回
    ///   - rectEdges: 自定义返回手势方向（注意这里只有left/right）
    func configureTransition(_ presentingVC: UIViewController?,
                             subtype: GXAnimationSubtype,
                             isPush: Bool,
                             interacted: Bool,
                             rectEdges: UIRectEdge = .left)
    {
        self.presentingViewController = presentingVC
        self.isNavPush = isPush
        self.subtype = subtype
        guard presentingVC != nil && interacted else { return }
        
        let panEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgePanGestureHandler(_:)))
        panEdgeGesture.edges = rectEdges
        presentingVC?.view.addGestureRecognizer(panEdgeGesture)
        if let navc = presentingVC as? UINavigationController {
            panEdgeGesture.delegate = self
            navc.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    @objc func screenEdgePanGestureHandler(_ gesture: UIScreenEdgePanGestureRecognizer) {
        let fromVC = self.presentingViewController
        let velocity = abs(gesture.velocity(in: UIApplication.shared.windows.first).x)
        let changeX = abs(gesture.translation(in: UIApplication.shared.windows.first).x)
        var progress = changeX / fromVC!.view.frame.width
        progress = min(1.0, max(0.0, progress))

        switch gesture.state {
        case .began:
            self.interacting = true
            self.interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.interactivePopTransition?.completionCurve = .easeInOut
            if self.isNavPush {
                fromVC?.navigationController?.popViewController(animated: true)
            }
            else {
                fromVC?.dismiss(animated: true, completion: nil)
            }
        case .changed:
            self.interactivePopTransition?.update(progress)
        case .ended, .cancelled:
            self.interacting = false
            if velocity > 800.0 {
                self.interactivePopTransition?.finish()
            }
            else if progress > 0.4 {
                self.interactivePopTransition?.completionSpeed = progress
                self.interactivePopTransition?.finish()
            }
            else {
                self.interactivePopTransition?.completionSpeed = progress
                self.interactivePopTransition?.cancel()
            }
        default: break
        }
    }

    // MARK: - UIGestureRecognizerDelegate
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let navc = self.presentingViewController as? UINavigationController {
            if (gestureRecognizer == navc.interactivePopGestureRecognizer) {
                if navc.children.count > 1 {
                    return true
                }
            }
            else {
                if self.presentingViewController.children.count == 1 {
                    return true
                }
            }
        }
        return false
    }
    
    // MARK: - Subclass Override
    
    func presentViewAnimation(_ transitionContext: UIViewControllerContextTransitioning) {}
    func dismissViewAnimation(_ transitionContext: UIViewControllerContextTransitioning) {}
    
    // MARK: - Utility
    
    func addShadow(to view: UIView?) {
        self.shadowSuperView = view
        guard view != nil else { return }
        view!.layer.masksToBounds = false
        view!.layer.shadowOffset = CGSize(width: -1.0, height: 0.0)
        view!.layer.shadowRadius = 5.0
        view!.layer.shadowOpacity = 0.2
        view!.layer.shouldRasterize = true
        view!.layer.shadowPath = UIBezierPath(rect: view!.bounds).cgPath
    }
    
    func removeShadow(to view: UIView?) {
        guard view != nil else { return }
        view!.layer.shadowOffset = CGSize(width: 0, height: -3)
        view!.layer.shadowRadius = 3.0
        view!.layer.shadowOpacity = 0.0
        view!.layer.shouldRasterize = false
        view!.layer.shadowPath = nil
    }
    
    func addBackgroundView(to view: UIView) {
        self.backgroundView.frame = view.bounds
        view.addSubview(self.backgroundView)
    }
    
    func animateWithContext(_ transitionContext: UIViewControllerContextTransitioning,
                            isPresent: Bool,
                            animations: @escaping (() -> Void),
                            completion: ((Bool) -> Void)?)
    {
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            self.backgroundView.alpha = isPresent ? 0.3 : 0.0
            animations()
        } completion: { (finished) in
            self.backgroundView.removeFromSuperview()
            self.removeShadow(to: self.shadowSuperView)
            completion?(finished)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension GXAnimationBaseDelegate: UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    // MARK: - UIViewControllerAnimatedTransitioning
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 5
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.isPresentAnimationing ? self.presentViewAnimation(transitionContext):self.dismissViewAnimation(transitionContext)
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresentAnimationing = true
        return self
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresentAnimationing = false
        return self
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (self.interacting ? self.interactivePopTransition : nil)
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (self.interacting ? self.interactivePopTransition : nil)
    }
}

extension GXAnimationBaseDelegate: UINavigationControllerDelegate {
    // MARK: - UINavigationControllerDelegate
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (self.interacting ? self.interactivePopTransition : nil)
    }

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            self.isPresentAnimationing = true
            return self
        }
        else if operation == .pop {
            self.isPresentAnimationing = false
            return self
        }
        return nil
    }
}
