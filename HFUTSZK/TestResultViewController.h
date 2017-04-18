//
//  TestResultViewController.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/26.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FanPicture.h"

@interface TestResultViewController : UIViewController

- (instancetype)initWithScore:(NSInteger)score;

@property (nonatomic) NSInteger score;

@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *congratulation;
@property (nonatomic, strong) UIButton *pass;
@property (nonatomic, strong) UIView *circle;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) FanPicture *pie;

@end
