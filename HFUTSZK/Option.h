//
//  Option.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Option : UIView

+ (Option*) optionWithOption:(NSString*)option Order:(NSString*)order;

@property (nonatomic, strong) UIImageView *optionMark;
@property (nonatomic, strong) UILabel *option;
@property (nonatomic) BOOL selected;

@property (nonatomic, strong) UITapGestureRecognizer *tapForCheck;



@end
