//
//  SubjectViewController.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectView.h"
#import "SubjectModel.h"
#import "FMToolBar.h"

@interface SubjectViewController : UIViewController

- (instancetype) initWithCourse:(NSInteger)course;
- (instancetype)initWithCourse:(NSInteger)course Chapter:(NSInteger)chapter;
- (instancetype)initWrongWithCourse:(NSInteger)course;
- (instancetype)initCollectionWithCourse:(NSInteger)course;

@property (nonatomic) NSInteger course;
@property (nonatomic) NSInteger chapter;
@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger current;
@property (nonatomic) NSInteger currentSubject;

@property (nonatomic) NSInteger readType; //0表示练习模式，1表示阅读模式

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
