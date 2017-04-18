//
//  HFUTAlertController.h
//  Demo
//
//  Created by Flame on 2017/2/9.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, AlertStyle) {
    
    AlertStyleDefaultWithSingleButton,
    
    AlertStyleSuccessWithSingleButton,
    
    AlertStyleFailureWithSingleButton,
    
    AlertStyleInfoWithSingleButton,
    
    AlertStyleDefaultWithDoubleButton,
    
    AlertStyleSuccessWithDoubleButton,
    
    AlertStyleFailureWithDoubleButton,
    
    AlertStyleInfoWithDoubleButton,
};


@interface HFUTAlertController : UIViewController

typedef void (^Completion)(void);

@property (nonatomic, strong) UIImageView* styleMark;
@property (nonatomic, strong) UIView* styleMarkBG;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* messageLabel;
@property (nonatomic, strong) UIButton* defaultButton;
@property (nonatomic, strong) UIButton* cancelButton;
@property (nonatomic) AlertStyle alertStyle;

@property (nonatomic, strong) Completion successCompletion;
@property (nonatomic, strong) Completion failureCompletion;

+ (HFUTAlertController*)alertWithTitle:(NSString*)title message:(NSString*)message style:(AlertStyle)style;
+ (HFUTAlertController*)alertWithMessage:(NSString*)message style:(AlertStyle)style;

- (void)setDefaultCompletion:(Completion)completion;
- (void)setCancelCompletion:(Completion)completion;

- (void)setDefaultButtonTitle:(NSString*)title;
- (void)setCancelButtonTitle:(NSString*)title;


#pragma mark - 获取屏幕宽度和高度
#define FMScreenWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)
#define FMScreenHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)
#define FMScreenSize \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)


#pragma mark - 颜色
#define FMGreen ([UIColor colorWithRed:83.0/255 green:215.0/255 blue:105.0/255 alpha:1])
#define FMRed ([UIColor colorWithRed:238.0/255 green:69.0/255 blue:53.0/255 alpha:1])
#define FMGray ([UIColor colorWithRed:65.0/255 green:83.0/255 blue:104.0/255 alpha:1])

@end
