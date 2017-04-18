//
//  HomeView.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/12.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeView : UIView

@property (nonatomic, strong) UITableView *homeTabview;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *badge;



- (instancetype)initWithFrame:(CGRect)frame;


@end
