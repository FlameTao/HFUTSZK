//
//  HomeTableViewCell.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/12.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *courseImage;
@property (nonatomic, strong) UILabel *courseName;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *practice;
@property (nonatomic, strong) UIButton *watch;

@property (nonatomic, strong) UIButton *byType;
@property (nonatomic, strong) UIButton *byChapter;


@end
