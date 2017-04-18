//
//  HFUTNotificationCenter.m
//  HfutXC
//
//  Created by Flame on 2017/3/2.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "HFUTNotificationCenter.h"

@implementation HFUTNotificationCenter


+ (HFUTNotificationCenter*)notificationWithTitle:(NSString *)title Type:(NotificationType)type {
    HFUTNotificationCenter * notification = [[HFUTNotificationCenter alloc] init];
    [notification configWithTitle:title Type:type];
    notification.preBlock = ^{};
    notification.aftBlock = ^{};
    return notification;
}

- (void)configWithTitle:(NSString*)title Type:(NotificationType)type {
    _bacgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -36, [UIScreen mainScreen].bounds.size.width, 100)];
    _bacgroundView.backgroundColor = [UIColor whiteColor];
    _bacgroundView.layer.shadowColor = [UIColor grayColor].CGColor;
    _bacgroundView.layer.shadowOffset = CGSizeMake(0, 5);
    _bacgroundView.layer.shadowOpacity = 0.3;
    [self.view addSubview:_bacgroundView];
    
    _swipeUpForDestroy = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(eventForGesture:)];
    _swipeUpForDestroy.direction = UISwipeGestureRecognizerDirectionUp;
    [_bacgroundView addGestureRecognizer:_swipeUpForDestroy];
    _tapOnceForDestroy = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eventForGesture:)];
    _tapOnceForDestroy.numberOfTapsRequired = 1;
    [_bacgroundView addGestureRecognizer:_tapOnceForDestroy];
    
    switch (type) {
        case HFUTNotificationSuccess:
            _markView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notification_success.png"]];
            break;
        case HFUTNotificationError:
            _markView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notification_error.png"]];
            break;
        case HFUTNotificationInfo:
            _markView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notification_info.png"]];
            break;
        default:
            break;
    }
    if (type != HFUTNotificationDefault) {
        [_markView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_bacgroundView addSubview:_markView];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_markView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_bacgroundView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_markView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_bacgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
        NSArray *array = [NSArray arrayWithObjects:left, bottom, nil];
        [_bacgroundView addConstraints:array];
    }
    
    _notificationMessage = [[UILabel alloc] init];
    _notificationMessage.text = title;
    _notificationMessage.font = [UIFont systemFontOfSize:16];
    [_notificationMessage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bacgroundView addSubview:_notificationMessage];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_notificationMessage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_bacgroundView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:60];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_notificationMessage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_bacgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-13];
    NSArray *array = [NSArray arrayWithObjects:left, bottom, nil];
    [_bacgroundView addConstraints:array];
    
    
    CASpringAnimation * positionY = [CASpringAnimation animationWithKeyPath:@"position.y"];
    positionY.fromValue = [NSNumber numberWithFloat:-50];
    positionY.mass = 1;
    positionY.damping = 10;
    positionY.stiffness = 100;
    positionY.duration = 2.f;
    [_bacgroundView.layer addAnimation:positionY forKey:@"positon_come"];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self.view removeGestureRecognizer:_swipeUpForDestroy];
        [self.view removeGestureRecognizer:_tapOnceForDestroy];
        [self destroy];
    });
    
}

- (void)show {
    _preBlock();
    _window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    _window.windowLevel = UIWindowLevelStatusBar-1;
    _window.rootViewController = self;
    [_window makeKeyAndVisible];
}

- (void)destroy {
    CASpringAnimation *positionYGo = [CASpringAnimation animationWithKeyPath:@"position.y"];
    positionYGo.byValue = [NSNumber numberWithFloat:-64];
    positionYGo.duration = 1.f;
    [_bacgroundView.layer addAnimation:positionYGo forKey:@"position_go"];
    dispatch_time_t time_duration = dispatch_time(DISPATCH_TIME_NOW, 200ull*NSEC_PER_MSEC);
    dispatch_after(time_duration, dispatch_get_main_queue(), ^{
        _window.hidden = YES;
        _window = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HFUTNotificationDestroySuccess" object:self];
        _aftBlock();
    });
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)eventForGesture:(id)sender {
    [self destroy];
}

- (void)setPreBlock:(PreBlock)preBlock {
    _preBlock = preBlock;
}

- (void)setAftBlock:(PreBlock)aftBlock {
    _aftBlock = aftBlock;
}

@end
