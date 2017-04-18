//
//  FMToolBar.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/18.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TOOLBAR_HEIGHT 56

@interface FMToolBar : UIView

@property (nonatomic, strong) UIImageView *collectionImageView;
@property (nonatomic, strong) UILabel *collectionLabel;

@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIImageView *wrongImageView;
@property (nonatomic, strong) UILabel *wrongLabel;

@property (nonatomic, strong) UIImageView *subjectsImageView;
@property (nonatomic, strong) UILabel *subjectsLabel;

@property (nonatomic, strong) UIScrollView *selectView;


@property (nonatomic, strong) UIView *line;

@property (nonatomic) NSInteger opened; // 1表示打开,0表示关闭

+ (FMToolBar*)defaultFMToolBar;

- (void) updateSubjectLabelText:(NSString*)subjectLabelText;
- (void) updateWrongLabelText:(NSString*)wrongLabelText;
- (void) updateRightLabelText:(NSString*)rightLabelText;
- (void) updateCollection:(NSInteger)collection;

@end
