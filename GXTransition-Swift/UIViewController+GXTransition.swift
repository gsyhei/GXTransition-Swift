//
//  UIViewController+GXTransition.swift
//  GXTransitionSample
//
//  Created by Gin on 2020/11/18.
//

import UIKit

private var GX_DELEGATE = 0

public enum GXAnimationStyle: Int {
    case push      = 0
    case pushEdge  = 1
    case pushAll   = 2
    case sector    = 3
}

public extension UIViewController {
    /// 转场动画代理
    var gx_animatedDelegate: GXAnimationBaseDelegate? {
        get {
            return objc_getAssociatedObject(self, &GX_DELEGATE) as? GXAnimationBaseDelegate
        }
        set {
            objc_setAssociatedObject(self, &GX_DELEGATE, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// push
    /// - Parameters:
    ///   - viewController: 目标vc
    ///   - style: 转场动画类型
    ///   - subtype: 转场动画方向
    ///   - interacting: 是否开启手势返回
    ///   - rectEdges: 自定义返回手势方向（注意这里只有left/right）
    func gx_push(_ viewController: UIViewController,
                 style: GXAnimationStyle,
                 subtype: GXAnimationSubtype = .left,
                 interacting: Bool = true,
                 rectEdges: UIRectEdge = .left)
    {
        self.gx_gotoViewController(vc: viewController,
                                   isPush: true,
                                   style: style,
                                   subtype: subtype,
                                   interacted: interacting,
                                   rectEdges: rectEdges,
                                   completion: nil)
    }
    
    /// present
    /// - Parameters:
    ///   - viewControllerToPresent: : 目标vc
    ///   - style: 转场动画类型
    ///   - subtype: 转场动画方向
    ///   - interacting: 是否开启手势返回
    ///   - rectEdges: 自定义返回手势方向（注意这里只有left/right）
    ///   - completion: 完成回调
    func gx_present(_ viewControllerToPresent: UIViewController,
                    style: GXAnimationStyle,
                    subtype: GXAnimationSubtype = .left,
                    interacting: Bool = true,
                    rectEdges: UIRectEdge = .left,
                    completion: (() -> Void)? = nil)
    {
        self.gx_gotoViewController(vc: viewControllerToPresent,
                                   isPush: false,
                                   style: style,
                                   subtype: subtype,
                                   interacted: interacting,
                                   rectEdges: rectEdges,
                                   completion: completion)
    }
}

fileprivate extension UIViewController {
    
    func gx_gotoViewController(vc: UIViewController,
                               isPush: Bool,
                               style: GXAnimationStyle,
                               subtype: GXAnimationSubtype,
                               interacted: Bool,
                               rectEdges: UIRectEdge,
                               completion: (() -> Void)?)
    {
        switch style {
        case .push:
            self.gx_animatedDelegate = GXAnimationPushDelegate()
        case .pushEdge:
            self.gx_animatedDelegate = GXAnimationPushEdgeDelegate()
        case .pushAll:
            self.gx_animatedDelegate = GXAnimationPushAllDelegate()
        case .sector:
            self.gx_animatedDelegate = GXAnimationSectorDelegate()
        }
        
        self.gx_animatedDelegate?.configureTransition(vc, subtype: subtype, isPush: isPush, interacted: interacted, rectEdges: rectEdges)
        if isPush {
            self.navigationController?.delegate = self.gx_animatedDelegate
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            vc.transitioningDelegate = self.gx_animatedDelegate
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true, completion: completion)
        }
    }
    
}
