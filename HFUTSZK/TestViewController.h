//
//  TestViewController.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectView.h"
#import "SubjectModel.h"
#import "FMToolBar.h"

@interface TestViewController : UIViewController

- (instancetype)initWithTestCourse:(NSInteger)course;

@property (nonatomic) NSInteger course;

@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger current;
@property (nonatomic) NSInteger currentSubject;

@property (nonatomic) NSInteger minute;
@property (nonatomic) NSInteger second;

@property (nonatomic, strong) NSTimer *time;

@property (nonatomic) NSInteger rightNum;
@property (nonatomic) NSInteger wrongNum;





@property (nonatomic, strong) SubjectView *view0;
@property (nonatomic, strong) SubjectView *view1;
@property (nonatomic, strong) SubjectView *view2;
@property (nonatomic, strong) NSArray *subjecViewArray;
@property (nonatomic, strong) NSArray *subjectArray;


@property (nonatomic, strong) FMToolBar *fmtool;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeOfView0;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeOfView0;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeOfView1;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeOfView1;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeOfView2;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeOfView2;



@end
