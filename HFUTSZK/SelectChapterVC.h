//
//  SelectChapterVC.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/19.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectChapterVC : UIViewController

@property (nonatomic) NSInteger course;
@property (nonatomic) NSInteger chapter;
@property (nonatomic, strong) UILabel *courseName;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UISwipeGestureRecognizer *rightForRet;

+ (SelectChapterVC*)selectWithCourse:(NSInteger)course;

- (void) initViewWithCourse:(NSInteger)course;

@end
