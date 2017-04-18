//
//  SelectCourseVC.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/22.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCourseVC : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightForRet;

+ (SelectCourseVC*)selectWrongCourse;
+ (SelectCourseVC*)selectCollectionCourse;

@end
