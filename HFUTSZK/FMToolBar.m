//
//  FMToolBar.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/18.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "FMToolBar.h"
#import "Define.h"

@implementation FMToolBar

static FMToolBar * _instance;

+ (FMToolBar*)defaultFMToolBar {
//    static dispatch_once_t one;
//    dispatch_once(&one, ^{
//        CGFloat width = [UIScreen mainScreen].bounds.size.width;
//        CGFloat height = [UIScreen mainScreen].bounds.size.height;
//        CGFloat y = height - 64 - TOOLBAR_HEIGHT;
//        _instance = [[FMToolBar alloc] initWithFrame:CGRectMake(0, y, width, height*3/4)];
//        [_instance initLine];
//        [_instance initCollection];
//        [_instance initSubjects];
//        [_instance initRight];
//        [_instance initWrong];
//        [_instance initSelectView];
//        _instance.opened = 0;
//    });
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat y = height - 64 - TOOLBAR_HEIGHT;
    _instance = [[FMToolBar alloc] initWithFrame:CGRectMake(0, y, width, height*3/4)];
    [_instance initLine];
    [_instance initCollection];
    [_instance initSubjects];
    [_instance initRight];
    [_instance initWrong];
    [_instance initSelectView];
    _instance.opened = 0;
    _instance.backgroundColor = [UIColor whiteColor];
    return _instance;
}

- (void)initSelectView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    _selectView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 56, width, height*3/4-56)];
    _selectView.pagingEnabled = NO;
    _selectView.scrollEnabled = YES;
    _selectView.bounces = YES;
    _selectView.alwaysBounceVertical = YES;
    //_selectView.contentSize = CGSizeMake(width, 1000);
    [self addSubview:_selectView];
}

- (void)initLine {
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    self.line.backgroundColor = FMColorWithHex(0xbcbcbc);
    [self addSubview:self.line];
}


- (void)initCollection {
    _collectionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 20, 20)];
    _collectionImageView.image = [UIImage imageNamed:@"icon_coll"];
    [self addSubview:_collectionImageView];

    
    _collectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(31, 17, 50, 20)];
    _collectionLabel.text = @"收藏";
    _collectionLabel.textColor = FMColorWithHex(THEME_COLOR);
    _collectionLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_collectionLabel];
}


- (void)initSubjects {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _subjectsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*3/4-20, 16, 20, 20)];
    _subjectsImageView.image = [UIImage imageNamed:@"icon_more"];
    [self addSubview:_subjectsImageView];

    _subjectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*3/4+1, 17, 100, 20)];
    _subjectsLabel.text = @"0/0";
    _subjectsLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_subjectsLabel];
    
}


- (void)initRight {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/4+10, 16, 20, 20)];
    _rightImageView.image = [UIImage imageNamed:@"icon_right"];
    [self addSubview:_rightImageView];
    
    
    _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/4+31, 17, 100, 20)];
    _rightLabel.text = @"0";
    _rightLabel.textColor = [UIColor greenColor];
    _rightLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_rightLabel];
    
}

- (void)initWrong {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _wrongImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-10, 16, 20, 20)];
    _wrongImageView.image = [UIImage imageNamed:@"icon_wrong"];
    [self addSubview:_wrongImageView];
    
    _wrongLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2+11, 17, 100, 20)];
    _wrongLabel.text = @"0";
    _wrongLabel.textColor = [UIColor redColor];
    _wrongLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_wrongLabel];
}


- (void) updateSubjectLabelText:(NSString*)subjectLabelText {
    _subjectsLabel.text = subjectLabelText;
}
- (void) updateWrongLabelText:(NSString*)wrongLabelText {
    _wrongLabel.text = wrongLabelText;
}
- (void) updateRightLabelText:(NSString*)rightLabelText {
    _rightLabel.text = rightLabelText;
}
- (void) updateCollection:(NSInteger)collection {
    if (collection == 0) {
        _collectionLabel.text = @"收藏";
        _collectionImageView.image = [UIImage imageNamed:@"icon_coll"];
    } else if (collection == 1) {
        _collectionLabel.text = @"已收藏";
        _collectionImageView.image = [UIImage imageNamed:@"icon_colled"];
    }
}


@end
