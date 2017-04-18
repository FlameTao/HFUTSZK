//
//  HFUTPresentingAnimator.m
//  Demo
//
//  Created by Flame on 2017/2/10.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "HFUTPresentingAnimator.h"
#import "pop/Pop.h"
#import "Masonry.h"

@implementation HFUTPresentingAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromVC.view.userInteractionEnabled = NO;
    
    
    UIView *dimmingView = [[UIView alloc] initWithFrame:fromVC.view.bounds];
    dimmingView.backgroundColor = [UIColor grayColor];
    dimmingView.layer.opacity = 0.0;
    
    
    _hfutvc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //[self initAlert];
    
    
    [transitionContext.containerView addSubview:dimmingView];
    [transitionContext.containerView addSubview:_hfutvc.view];
    
    
    //view animation
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.toValue = @(transitionContext.containerView.center.y);
    positionAnimation.springBounciness = 5.0;
    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        if (_hfutvc.alertStyle == AlertStyleDefaultWithSingleButton || _hfutvc.alertStyle == AlertStyleDefaultWithDoubleButton) {
            //
        } else {
            //styleMarkBG animation
            POPSpringAnimation *markBGBounds = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
            CGFloat size = CGRectGetWidth(_hfutvc.view.bounds);
            markBGBounds.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, size*0.3, size*0.3)];
            markBGBounds.springSpeed = 0;
            POPSpringAnimation *markBGCorner = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
            markBGCorner.toValue = @(size*0.15);
            markBGBounds.springSpeed = 1;
            
            
            //styleMark animation
            POPSpringAnimation *markBounds = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
            markBounds.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, size*0.2, size*0.2)];
            markBounds.springSpeed = 0;
            POPSpringAnimation *markCorner = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
            markCorner.toValue = @(size*0.1);
            markCorner.springSpeed = 1;
            POPSpringAnimation *markOpacity = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
            markOpacity.toValue = @(1);
            markOpacity.springSpeed = 0;
            
            [_hfutvc.styleMarkBG.layer pop_addAnimation:markBGBounds forKey:@"markBounds"];
            [_hfutvc.styleMarkBG.layer pop_addAnimation:markBGCorner forKey:@"markCorner"];
            [_hfutvc.styleMark.layer pop_addAnimation:markBounds forKey:@"markBounds"];
            [_hfutvc.styleMark.layer pop_addAnimation:markCorner forKey:@"markCorner"];
        }
       
        [transitionContext completeTransition:YES];
    }];
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 20;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.5);
    
    
    [_hfutvc.view.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    [_hfutvc.view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

@end
