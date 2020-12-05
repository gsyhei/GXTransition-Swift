# GXTransition-Swift
Swift版本的iOS常用转场动画（包括自定义和iOS自带转场动画）
Commonly used transition animation in iOS (including custom transition animation and iOS own transition animation).
有建议可以联系QQ交流群:1101980843，喜欢就给个star哦，谢谢关注！
<p align="center">
<img src="https://github.com/gsyhei/GXCardView-Swift/blob/master/QQ.jpeg">
</p>

Sample renderings
--
<p align="center">
<img src="https://github.com/gsyhei/GXTransition-Swift/blob/main/GXTransition-Swift.gif">
</p>

Requirements
--
<p align="left">
<a href="https://github.com/gsyhei/GXTransition-Swift"><img src="https://img.shields.io/badge/platform-ios%209.0-yellow.svg"></a>
<a href="https://github.com/gsyhei/GXTransition-Swift"><img src="https://img.shields.io/github/license/johnlui/Pitaya.svg?style=flat"></a>
<a href="https://github.com/gsyhei/GXTransition-Swift"><img src="https://img.shields.io/badge/language-Swift%205.0-orange.svg"></a>
</p>

Usage in you Podfile:
--

```
pod 'GXTransition-Swift'
```
* 其它版本 [OC版本](https://github.com/gsyhei/GXTransition)
```
pod 'GXTransition'
```

使用方法
--
首先#import "UIViewController+GXTransitionDelegate.h"，然后直接使用扩展方法就行，是不是很简单😁。

```swift

/// push
/// - Parameters:
///   - viewController: 目标vc
///   - style: 转场动画类型
///   - style注意事项：不支持cube与oglFlip，push动画不支持transitionContext.containerView.layer.sublayerTransform
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

```

支持的转场动画类型
--

```swift

public enum GXAnimationStyle: Int {
    case push      = 0
    case pushEdge  = 1
    case pushAll   = 2
    case sector    = 3
    case cube      = 4
    case oglFlip   = 5
}

```

License
--
MIT

