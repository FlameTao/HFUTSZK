//
//  SubjectViewController.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "TestViewController.h"
#import "Masonry.h"
#import "pop/POP.h"
#import "HFUTNotificationCenter.h"
#import "PageCache.h"
#import "SubjectModel.h"
#import "TestResultViewController.h"
#import "HFUTAlert.h"



@interface TestViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation TestViewController

int selected[50] = {0};

- (instancetype)initWithTestCourse:(NSInteger)course {
    self = [self init];
    if (self != nil) {
        _subjectArray = [SubjectModel subjectTestWithCourse:course];
        self.course = course;
        self.count = _subjectArray.count;
        self.current = 1;
        self.currentSubject = 1;
        self.minute = 30;
        self.second = 0;
        self.rightNum = 0;
        self.wrongNum = 0;
        self.title = [NSString stringWithFormat:@"%02ld:%02ld", (long)self.minute, (long)self.second];
        
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    HFUTAlertController * alert = [HFUTAlertController alertWithTitle:@"提示" message:@"判断题：15题\n单选题：20题\n多选题：15题\n时间：30分钟" style:AlertStyleDefaultWithDoubleButton];
    [alert setDefaultButtonTitle:@"开始考试"];
    [alert setCancelButtonTitle:@"离开考试"];
    [alert setDefaultCompletion:^{
        self.time = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    }];
    [alert setCancelCompletion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    alert.transitioningDelegate = self;
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
    for (int i = 0; i<50; i++) {
        selected[i]=0;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ret"] style:UIBarButtonItemStylePlain target:self action:@selector(ret:)];
    self.navigationItem.leftBarButtonItem = itemleft;
//    UIBarButtonItem *itemright = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"readmode"] style:UIBarButtonItemStylePlain target:self action:@selector(readMode:)];
//    self.navigationItem.rightBarButtonItem = itemright;
    UIBarButtonItem *itemright = [[UIBarButtonItem alloc] initWithTitle:@"交卷" style:UIBarButtonItemStylePlain target:self action:@selector(commit:)];
    self.navigationItem.rightBarButtonItem = itemright;
    
    
    if (_count == 0) {
        //
        UILabel *notice = [[UILabel alloc] init];
        notice.text = @"抱歉！没有数据";
        notice.textColor = [UIColor grayColor];
        notice.font = [UIFont systemFontOfSize:24];
        notice.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:notice];
        [notice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
        
    } else {
        [self initSubjectView];
        [self initSwipe];
        
        NSInteger views = (_currentSubject-1)%3;
        if (views == 1) {
            [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:1];
            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        } else if (views == 2) {
            [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:0];
            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        }
        [[_subjecViewArray objectAtIndex:(_current+2)%3] showSubject:[_subjectArray objectAtIndex:(_current-1)%_count]];
        [[_subjecViewArray objectAtIndex:(_current+1)%3] showSubject:[_subjectArray objectAtIndex:(_current-2+_count)%_count]];
        [[_subjecViewArray objectAtIndex:(_current)%3] showSubject:[_subjectArray objectAtIndex:(_current)%_count]];
        
        [self initTap];
        
        [self initFMTool];
        _fmtool.userInteractionEnabled = YES;
        [self updateSubjectNum];
        [self updateCollection];
        [self updateRightNum];
        [self updateWrongNum];
        
        
        UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eventForCollection)];
        tap0.numberOfTapsRequired = 1;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eventForCollection)];
        tap1.numberOfTapsRequired = 1;
        _fmtool.collectionLabel.userInteractionEnabled=YES;
        _fmtool.collectionImageView.userInteractionEnabled=YES;
        [_fmtool.collectionLabel addGestureRecognizer:tap0];
        [_fmtool.collectionImageView addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eventForSelectSubject:)];
        tap2.numberOfTapsRequired = 1;
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eventForSelectSubject:)];
        tap2.numberOfTapsRequired = 1;
        _fmtool.subjectsLabel.userInteractionEnabled = YES;
        _fmtool.subjectsImageView.userInteractionEnabled = YES;
        [_fmtool.subjectsLabel addGestureRecognizer:tap2];
        [_fmtool.subjectsImageView addGestureRecognizer:tap3];
        
        
    }
    //    NSLog(@"%ld", (long)_course);
    //    NSLog(@"%@", [self.view subviews]);
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - 响应事件

- (void)ret:(id)sender {
    HFUTAlertController * alert = [HFUTAlertController alertWithTitle:@"提示" message:@"确定离开测试？" style:AlertStyleDefaultWithDoubleButton];
    [alert setDefaultCompletion:^{
        [_time invalidate];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert setCancelCompletion:^{
    }];
    alert.transitioningDelegate = self;
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)commit:(id)sender { //交卷
    HFUTAlertController * alert = [HFUTAlertController alertWithTitle:@"提示" message:@"提交考卷？" style:AlertStyleDefaultWithDoubleButton];
    [alert setDefaultCompletion:^{
        [_time invalidate];
        TestResultViewController *vc = [[TestResultViewController alloc] initWithScore:_rightNum*2];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [alert setCancelCompletion:^{
    }];
    alert.transitioningDelegate = self;
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
}

- (void)updateTime {
    if (_minute == 0 && _second == 0) {
        [_time invalidate];
        HFUTAlertController * alert = [HFUTAlertController alertWithTitle:@"提示" message:@"考试时间已过\n请提交考卷" style:AlertStyleDefaultWithSingleButton];
        [alert setDefaultCompletion:^{
            TestResultViewController *vc = [[TestResultViewController alloc] initWithScore:_rightNum*2];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        alert.transitioningDelegate = self;
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    } else {
        if (_second == 0) {
            _second = 59;
            _minute--;
        } else {
            _second--;
        }
    }
    self.title = [NSString stringWithFormat:@"%02ld:%02ld", (long)_minute, (long)_second];
}



- (void)eventForNext:(UIPanGestureRecognizer*)sender {
    if (_current == _count) {
        HFUTNotificationCenter *notification = [HFUTNotificationCenter notificationWithTitle:@"最后一题啦！" Type:HFUTNotificationInfo];
        [notification show];
        return;
    }
    _view0.userInteractionEnabled = NO;
    _view1.userInteractionEnabled = NO;
    _view2.userInteractionEnabled = NO;
    
    
    NSUInteger i = (_current+2) % 3;  // 当前view号
    
    _currentSubject++;
    
    [self updateCollection];

    [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:1];
    
    POPSpringAnimation *positonX = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positonX.fromValue = [NSNumber numberWithFloat:self.view.frame.size.width];
    [positonX setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        if (finished == YES) {
            //            NSLog(@"当前_current:%ld", _current+1);
            //            NSLog(@"view%ld--取第%ld个题目", (i+2)%3, (_current+1)%_count);
            [[_subjecViewArray objectAtIndex:(i+2)%3] showSubject:[_subjectArray objectAtIndex:(_current+1)%_count]]; // 当进入下一个页面时，加载下下一个数据到当前view的前一个页面，当前view成前一个页面
            
//            if ([[_selected objectAtIndex:(_currentSubject)%_count] integerValue] == 1) {
//                [self showAnswer:1];
//            }

            if (selected[(_currentSubject%_count)] == 1) {
                [self showAnswer:1];
            }
            
            [self initTap];
            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            _view0.userInteractionEnabled = YES;
            _view1.userInteractionEnabled = YES;
            _view2.userInteractionEnabled = YES;
            _current++;
            [self updateSubjectNum];
        }
    }];
    UIScrollView *sv = [_subjecViewArray objectAtIndex:(i+1)%3];
    [sv.layer pop_addAnimation:positonX forKey:@"sv_left"];
    
}

- (void)eventForPre:(UIPanGestureRecognizer*)sender {
    if (_current == 1) {
        HFUTNotificationCenter *notification = [HFUTNotificationCenter notificationWithTitle:@"已经是第一题了！" Type:HFUTNotificationInfo];
        [notification show];
        return;
    }
    _view0.userInteractionEnabled = NO;
    _view1.userInteractionEnabled = NO;
    _view2.userInteractionEnabled = NO;
    
    NSUInteger i = (_current+2) % 3;
    
    _currentSubject--;
    
    [self updateCollection];
    
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:2];
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    
    POPSpringAnimation *positonX = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positonX.fromValue = [NSNumber numberWithFloat:-self.view.frame.size.width];
    [positonX setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        if (finished == YES) {
            //            NSLog(@"当前_current:%ld", _current-1);
            //            NSLog(@"view%ld--取第%ld个题目", (i+1)%3, (_current-3+_count)%_count);
            [[_subjecViewArray objectAtIndex:(i+1)%3] showSubject:[_subjectArray objectAtIndex:(_current-3+_count)%_count]];
//            if ([[_selected objectAtIndex:(_currentSubject-2+_count)%_count] integerValue] == 1) {
//                [self showAnswer:-1];
//            }
            if (selected[(_currentSubject-2+_count)%_count] == 1) {
                [self showAnswer:-1];
            }
            [self initTap];
            _view0.userInteractionEnabled = YES;
            _view1.userInteractionEnabled = YES;
            _view2.userInteractionEnabled = YES;
            _current--;
            [self updateSubjectNum];
        }
    }];
    UIScrollView *sv = [_subjecViewArray objectAtIndex:(i+2)%3];
    [sv.layer pop_addAnimation:positonX forKey:@"sv_right"];
}



- (void)showAnswer:(NSInteger)nums { // 0表示改变当前view，1表示改变下一个view，-1表示改变前一个view
    SubjectView *view = [_subjecViewArray objectAtIndex:(_currentSubject+2+nums)%3];
    [view closeOpUse];
    SubjectModel *model = [_subjectArray objectAtIndex:(_currentSubject-1+nums+_count)%_count];
    //NSLog(@"%ld:%@", (long)(_currentSubject-1+nums+_count)%_count,model.subjectMyAnswer);
    NSString *answer = model.subjectMyAnswer;
    NSString *realAnswer = model.subjectAnswer;
    if (model.subjectType == 1) {
        
        if (answer) {
            if ([answer isEqualToString:@"0"]) {
                view.opA.optionMark.image = [UIImage imageNamed:@"fed"];
                view.opB.optionMark.image = [UIImage imageNamed:@"ted"];
            } else {
                view.opB.optionMark.image = [UIImage imageNamed:@"fed"];
                view.opA.optionMark.image = [UIImage imageNamed:@"ted"];
            }
        } else {
            if ([realAnswer isEqualToString:@"1"]) {
                view.opA.optionMark.image = [UIImage imageNamed:@"ted"];
            } else {
                view.opB.optionMark.image = [UIImage imageNamed:@"ted"];
            }
        }
        
    } else if (model.subjectType == 2) {
        if (answer) {
            if ([answer isEqualToString:@"0"]) {
                view.opA.optionMark.image = [UIImage imageNamed:@"fed"];
            } else if ([answer isEqualToString:@"1"]) {
                view.opB.optionMark.image = [UIImage imageNamed:@"fed"];
            } else if ([answer isEqualToString:@"2"]) {
                view.opC.optionMark.image = [UIImage imageNamed:@"fed"];
            } else {
                view.opD.optionMark.image = [UIImage imageNamed:@"fed"];
            }
            
            if ([realAnswer isEqualToString:@"A"]) {
                view.opA.optionMark.image = [UIImage imageNamed:@"ted"];
            } else if ([realAnswer isEqualToString:@"B"]) {
                view.opB.optionMark.image = [UIImage imageNamed:@"ted"];
            } else if ([realAnswer isEqualToString:@"C"]) {
                view.opC.optionMark.image = [UIImage imageNamed:@"ted"];
            } else {
                view.opD.optionMark.image = [UIImage imageNamed:@"ted"];
            }
        } else {
            if ([realAnswer isEqualToString:@"A"]) {
                view.opA.optionMark.image = [UIImage imageNamed:@"ted"];
            } else if ([realAnswer isEqualToString:@"B"]) {
                view.opB.optionMark.image = [UIImage imageNamed:@"ted"];
            } else if ([realAnswer isEqualToString:@"C"]) {
                view.opC.optionMark.image = [UIImage imageNamed:@"ted"];
            } else {
                view.opD.optionMark.image = [UIImage imageNamed:@"ted"];
            }
        }
        
    } else {
        if (answer) {
            if ([answer containsString:@"A"]) {
                view.opA.optionMark.image = [UIImage imageNamed:@"fed"];
            }
            if ([answer containsString:@"B"]) {
                view.opB.optionMark.image = [UIImage imageNamed:@"fed"];
            }
            if ([answer containsString:@"C"]) {
                view.opC.optionMark.image = [UIImage imageNamed:@"fed"];
            }
            if ([answer containsString:@"D"]) {
                view.opD.optionMark.image = [UIImage imageNamed:@"fed"];
            }
            if ([realAnswer containsString:@"A"]) {
                view.opA.optionMark.image = [UIImage imageNamed:@"ted"];
            }
            if ([realAnswer containsString:@"B"]) {
                view.opB.optionMark.image = [UIImage imageNamed:@"ted"];
            }
            if ([realAnswer containsString:@"C"]) {
                view.opC.optionMark.image = [UIImage imageNamed:@"ted"];
            }
            if ([realAnswer containsString:@"D"]) {
                view.opD.optionMark.image = [UIImage imageNamed:@"ted"];
            }
        } else {
            if ([realAnswer containsString:@"A"]) {
                view.opA.optionMark.image = [UIImage imageNamed:@"ted"];
            }
            if ([realAnswer containsString:@"B"]) {
                view.opB.optionMark.image = [UIImage imageNamed:@"ted"];
            }
            if ([realAnswer containsString:@"C"]) {
                view.opC.optionMark.image = [UIImage imageNamed:@"ted"];
            }
            if ([realAnswer containsString:@"D"]) {
                view.opD.optionMark.image = [UIImage imageNamed:@"ted"];
            }
        }
    }
}


#pragma mark - 初始化组件

- (void) initSwipe {
    _leftSwipeOfView0 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(eventForNext:)];
    _leftSwipeOfView0.direction = UISwipeGestureRecognizerDirectionLeft;
    _rightSwipeOfView0 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(eventForPre:)];
    _rightSwipeOfView0.direction = UISwipeGestureRecognizerDirectionRight;
    [_view0 addGestureRecognizer:_leftSwipeOfView0];
    [_view0 addGestureRecognizer:_rightSwipeOfView0];
    
    _leftSwipeOfView1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(eventForNext:)];
    _leftSwipeOfView1.direction = UISwipeGestureRecognizerDirectionLeft;
    _rightSwipeOfView1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(eventForPre:)];
    _rightSwipeOfView1.direction = UISwipeGestureRecognizerDirectionRight;
    [_view1 addGestureRecognizer:_leftSwipeOfView1];
    [_view1 addGestureRecognizer:_rightSwipeOfView1];
    
    _leftSwipeOfView2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(eventForNext:)];
    _leftSwipeOfView2.direction = UISwipeGestureRecognizerDirectionLeft;
    _rightSwipeOfView2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(eventForPre:)];
    _rightSwipeOfView0.direction = UISwipeGestureRecognizerDirectionRight;
    [_view2 addGestureRecognizer:_leftSwipeOfView2];
    [_view2 addGestureRecognizer:_rightSwipeOfView2];
    
}

- (void) initTap {
    [_view0.opA.tapForCheck addTarget:self action:@selector(check:)];
    [_view0.opB.tapForCheck addTarget:self action:@selector(check:)];
    [_view0.opC.tapForCheck addTarget:self action:@selector(check:)];
    [_view0.opD.tapForCheck addTarget:self action:@selector(check:)];
    
    [_view1.opA.tapForCheck addTarget:self action:@selector(check:)];
    [_view1.opB.tapForCheck addTarget:self action:@selector(check:)];
    [_view1.opC.tapForCheck addTarget:self action:@selector(check:)];
    [_view1.opD.tapForCheck addTarget:self action:@selector(check:)];
    
    [_view2.opA.tapForCheck addTarget:self action:@selector(check:)];
    [_view2.opB.tapForCheck addTarget:self action:@selector(check:)];
    [_view2.opC.tapForCheck addTarget:self action:@selector(check:)];
    [_view2.opD.tapForCheck addTarget:self action:@selector(check:)];
    
    SubjectView *view = [_subjecViewArray objectAtIndex:(_currentSubject-1)%3];
    SubjectModel *model = [_subjectArray objectAtIndex:_currentSubject-1];
    if (model.subjectType == 3) {
        [view.commit addTarget:self action:@selector(eventForCommit) forControlEvents:UIControlEventTouchUpInside];
    }
}





- (void) initFMTool {
    _fmtool = [FMToolBar defaultFMToolBar];
    _fmtool.backgroundColor = [UIColor whiteColor];
    _fmtool.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_fmtool];
    
    CGFloat scrollViewHeight = (_count/5)*60+100;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat spacing = (width-200)/6;
    _fmtool.selectView.contentSize = CGSizeMake(width, scrollViewHeight);
    
    for (NSInteger i=0; i<_count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(spacing+(i%5)*(spacing+40), 20+(i/5)*60, 40, 40);
        [btn setTitle:[NSString stringWithFormat:@"%ld", (long)i+1] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"select_btn_bg"] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTintColor:[UIColor grayColor]];
        [btn setTag:i+1];
        
        [btn addTarget:self action:@selector(eventForSelectSubjectNum:) forControlEvents:UIControlEventTouchUpInside];
        
        [_fmtool.selectView addSubview:btn];
    }
}

- (void) initSubjectView {
    _view0 = [[SubjectView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64 - 56)];
    _view1 = [[SubjectView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64 - 56)];
    _view2 = [[SubjectView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64 - 56)];
    [self.view addSubview:_view2];
    [self.view addSubview:_view1];
    [self.view addSubview:_view0];
    _view0.backgroundColor = [UIColor whiteColor];
    _view1.backgroundColor = [UIColor whiteColor];
    _view2.backgroundColor = [UIColor whiteColor];
    
    // 阴影
    _view0.layer.shadowOpacity = 0.5;
    _view0.layer.shadowColor = [UIColor grayColor].CGColor;
    _view0.layer.shadowRadius = 5;
    _view0.layer.shadowOffset = CGSizeMake(1, 1);
    _view1.layer.shadowOpacity = 0.5;
    _view1.layer.shadowColor = [UIColor grayColor].CGColor;
    _view1.layer.shadowRadius = 5;
    _view1.layer.shadowOffset = CGSizeMake(1, 1);
    _view2.layer.shadowOpacity = 0.5;
    _view2.layer.shadowColor = [UIColor grayColor].CGColor;
    _view2.layer.shadowRadius = 5;
    _view2.layer.shadowOffset = CGSizeMake(1, 1);
    
    _subjecViewArray = [NSArray arrayWithObjects:_view0, _view1, _view2, nil];
}

- (void) updateSubjectNum {
    NSString *subjecNum = [NSString stringWithFormat:@"%ld/", (long)_current];
    subjecNum = [subjecNum stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)_count]];
    [_fmtool updateSubjectLabelText:subjecNum];
}

- (void) updateCollection { // 在当前的_current没有改变前调用
    [_fmtool updateCollection:((SubjectModel*)[_subjectArray objectAtIndex:(_currentSubject-1)]).subjectCollection];
}

- (void) updateRightNum {
    [_fmtool updateRightLabelText:[NSString stringWithFormat:@"%ld", (long)_rightNum]];
}

- (void) updateWrongNum {
    [_fmtool updateWrongLabelText:[NSString stringWithFormat:@"%ld", (long)_wrongNum]];
}

- (void) check:(UIGestureRecognizer*)recognizer {
    SubjectModel *model = [_subjectArray objectAtIndex:(_currentSubject-1)];
    SubjectView *view = [_subjecViewArray objectAtIndex:(_currentSubject-1)%3];
    if (model.subjectType == 1) {
//        NSNumber *selected = [_selected objectAtIndex:_currentSubject-1];
//        selected = [NSNumber numberWithInteger:1];

        selected[_currentSubject-1] = 1;
        
        [view closeOpUse];
        if ([model.subjectAnswer isEqualToString:@"1"]^(recognizer.view.tag==1)) {
            // 选择正确
            self.view.userInteractionEnabled = NO;
            _rightNum++;
            [self updateRightNum];
            [view successMarkWithSelectedOpsition:recognizer.view.tag subjectType:model.subjectType];
            HFUTNotificationCenter *notification = [HFUTNotificationCenter notificationWithTitle:@"恭喜你" Type:HFUTNotificationSuccess];
            [notification show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(800 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                self.view.userInteractionEnabled = YES;
                [self eventForNext:nil];
            });
            
        } else {
            // 选择错误
            _wrongNum++;
            [self updateWrongNum];
            HFUTNotificationCenter *notification = [HFUTNotificationCenter notificationWithTitle:@"请认真检查" Type:HFUTNotificationError];
            [notification show];
            model.subjectMyAnswer = [NSString stringWithFormat:@"%ld", (long)recognizer.view.tag];
            [view failureMarkWithSelectedOpsition:recognizer.view.tag subjectModel:model];
            [SubjectModel updateWrongWithSubjectID:model.subjectID andCourse:_course andMyAnswer:[NSString stringWithFormat:@"%ld", (long)recognizer.view.tag]];
            
        }
    } else if (model.subjectType == 2) {
//        NSNumber *selected = [_selected objectAtIndex:_currentSubject-1];
//        selected = [NSNumber numberWithInteger:1];
        selected[_currentSubject-1] = 1;
        [view closeOpUse];
        NSInteger answer = [model.subjectAnswer characterAtIndex:0] - 65;
        if (answer == recognizer.view.tag) {
            self.view.userInteractionEnabled = NO;
            _rightNum++;
            [self updateRightNum];
            [view successMarkWithSelectedOpsition:recognizer.view.tag subjectType:model.subjectType];
            HFUTNotificationCenter *notification = [HFUTNotificationCenter notificationWithTitle:@"恭喜你" Type:HFUTNotificationSuccess];
            [notification show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(800 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                self.view.userInteractionEnabled = YES;
                [self eventForNext:nil];
            });
            
        } else {
            _wrongNum++;
            [self updateWrongNum];
            HFUTNotificationCenter *notification = [HFUTNotificationCenter notificationWithTitle:@"请认真检查" Type:HFUTNotificationError];
            [notification show];
            model.subjectMyAnswer = [NSString stringWithFormat:@"%ld", (long)recognizer.view.tag];
            [view failureMarkWithSelectedOpsition:recognizer.view.tag subjectModel:model];
            [SubjectModel updateWrongWithSubjectID:model.subjectID andCourse:_course andMyAnswer:[NSString stringWithFormat:@"%ld", (long)recognizer.view.tag]];
        }
    } else {
        Option *op = (Option*)recognizer.view;
        if (recognizer.view.tag == 0) {
            if (op.selected == NO) {
                op.optionMark.image = [UIImage imageNamed:@"aed"];
                op.selected = YES;
            } else {
                op.optionMark.image = [UIImage imageNamed:@"a"];
                op.selected = NO;
            }
        } else if (recognizer.view.tag == 1) {
            if (op.selected == NO) {
                op.optionMark.image = [UIImage imageNamed:@"bed"];
                op.selected = YES;
            } else {
                op.optionMark.image = [UIImage imageNamed:@"b"];
                op.selected = NO;
            }
        } else if (recognizer.view.tag == 2) {
            if (op.selected == NO) {
                op.optionMark.image = [UIImage imageNamed:@"ced"];
                op.selected = YES;
            } else {
                op.optionMark.image = [UIImage imageNamed:@"c"];
                op.selected = NO;
            }
        } else {
            if (op.selected == NO) {
                op.optionMark.image = [UIImage imageNamed:@"ded"];
                op.selected = YES;
            } else {
                op.optionMark.image = [UIImage imageNamed:@"d"];
                op.selected = NO;
            }
        }
    }
    
}


#pragma mark - 响应事件
- (void) eventForCollection {
    SubjectModel *model = [_subjectArray objectAtIndex:(_currentSubject-1)];
    NSInteger collection = model.subjectCollection;
    NSInteger temp=_course;
    if (collection == 0) {
        HFUTNotificationCenter *nofitication = [HFUTNotificationCenter notificationWithTitle:@"收藏成功" Type:HFUTNotificationSuccess];
        [nofitication show];
        [SubjectModel updateCollection:1 withCourse:temp ID:model.subjectID];
        model.subjectCollection = 1;
        [self updateCollection];
    } else if (collection == 1) {
        HFUTNotificationCenter *nofitication = [HFUTNotificationCenter notificationWithTitle:@"已取消收藏" Type:HFUTNotificationSuccess];
        [nofitication show];
        [SubjectModel updateCollection:0 withCourse:temp ID:model.subjectID];
        model.subjectCollection = 0;
        [self updateCollection];
    }
}

- (void) eventForCommit {
//    NSNumber *selected = [_selected objectAtIndex:_currentSubject-1];
//    selected = [NSNumber numberWithInteger:1];

    selected[_currentSubject-1] = 1;
    
    SubjectView *view = [_subjecViewArray objectAtIndex:(_currentSubject-1)%3];
    [view closeOpUse]; // 关闭用户操作
    view.moreselectAnswer = @"";
    if (view.opA.selected == YES) {
        view.moreselectAnswer = @"A";
    }
    if (view.opB.selected == YES) {
        view.moreselectAnswer = [view.moreselectAnswer stringByAppendingString:@"B"];
    }
    if (view.opC.selected == YES) {
        view.moreselectAnswer = [view.moreselectAnswer stringByAppendingString:@"C"];
    }
    if (view.opD.selected == YES) {
        view.moreselectAnswer = [view.moreselectAnswer stringByAppendingString:@"D"];
    }
    SubjectModel *model = [_subjectArray objectAtIndex:_currentSubject-1];
    if ([model.subjectAnswer isEqualToString:view.moreselectAnswer]) {
        // 正确
        self.view.userInteractionEnabled = NO;
        _rightNum++;
        [self updateRightNum];
        [view moreSelectSuccess]; //更新UI
        HFUTNotificationCenter *notification = [HFUTNotificationCenter notificationWithTitle:@"恭喜你" Type:HFUTNotificationSuccess];
        [notification show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(800 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            self.view.userInteractionEnabled = YES;
            [self eventForNext:nil];
        });
    } else {
        // 错误
        _wrongNum++;
        [self updateWrongNum];
        HFUTNotificationCenter *notification = [HFUTNotificationCenter notificationWithTitle:@"请认真检查" Type:HFUTNotificationError];
        [notification show];
        [view moreSelectFailureWithSubjectModel:model]; //更新UI
        model.subjectMyAnswer = view.moreselectAnswer;
        [SubjectModel updateWrongWithSubjectID:model.subjectID andCourse:_course andMyAnswer:view.moreselectAnswer];
        
    }
}


- (void)eventForSelectSubject:(id)sender {
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    _fmtool.userInteractionEnabled = NO;
    if (_fmtool.opened == 0) {
        POPSpringAnimation *positonY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        positonY.toValue = [NSNumber numberWithFloat:height*5/8-64];
        [positonY setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            if (finished) {
                _fmtool.opened = 1;
                _fmtool.userInteractionEnabled = YES;
            }
        }];
        [_fmtool.layer pop_addAnimation:positonY forKey:@"fmtool_come"];
    } else {
        POPSpringAnimation *positonY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        positonY.toValue = [NSNumber numberWithFloat:height*11/8-120];
        [positonY setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            if (finished) {
                _fmtool.opened = 0;
                _fmtool.userInteractionEnabled = YES;
            }
        }];
        [_fmtool.layer pop_addAnimation:positonY forKey:@"fmtool_go"];
    }
}

- (void)eventForSelectSubjectNum:(id)sender {
    UIButton *btn = sender;
    
    NSInteger preViews = (_currentSubject-1)%3;
    
    _current=btn.tag;
    _currentSubject = _current;
    NSInteger views = (btn.tag-1)%3;
    
    [[_subjecViewArray objectAtIndex:(_current+2)%3] showSubject:[_subjectArray objectAtIndex:(_current-1)%_count]];
    [[_subjecViewArray objectAtIndex:(_current+1)%3] showSubject:[_subjectArray objectAtIndex:(_current-2+_count)%_count]];
    [[_subjecViewArray objectAtIndex:(_current)%3] showSubject:[_subjectArray objectAtIndex:(_current)%_count]];
    
    if (views == 0) {
        if (preViews == 1) {
            [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:0];
            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        } else if (preViews == 2) {
            [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:1];
            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        }
    } else if (views == 1) {
        if (preViews == 0) {
            [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:1];
            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        } else if (preViews == 2) {
            [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:0];
            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        }
    } else {
        if (preViews == 0) {
            [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:0];
            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        } else if (preViews == 1) {
            [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:1];
            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        }
    }
    [self initTap];
    if (selected[_currentSubject-1] == 1) {
        [self showAnswer:0];
    }
    if (selected[(_currentSubject-2+_count)%_count] == 1) {
        [self showAnswer:-1];
    }
    if (selected[(_currentSubject%_count)] == 1) {
        [self showAnswer:1];
    }
    
    [self updateCollection];
    [self updateSubjectNum];
    
    _fmtool.userInteractionEnabled = NO;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    POPSpringAnimation *positonY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positonY.toValue = [NSNumber numberWithFloat:height*11/8-120];
    [positonY setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        if (finished) {
            _fmtool.opened = 0;
            _fmtool.userInteractionEnabled = YES;
        }
    }];
    [_fmtool.layer pop_addAnimation:positonY forKey:@"fmtool_go_g"];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [HFUTPresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [HFUTDismissingAnimator new];
}

//#pragma mark - 存储缓存
//- (void)loadUserDefault:(NSInteger)course andChapter:(NSInteger)chapter {
//    PageCache *pageCache = [PageCache defaultPageCache];
//    NSArray *array = [pageCache.pageChacheArray objectAtIndex:course];
//    NSString *key;
//    if (chapter == -1) {
//        key = [array lastObject];
//    } else {
//        key = [array objectAtIndex:chapter];
//    }
//    NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:key];
//    if (value > _count) {
//        value = _count;
//    }
//    self.current = value;
//    self.currentSubject = self.current;
//}
//
//- (void)storeUserDefault:(NSInteger)course andChapter:(NSInteger)chapter {
//    PageCache *pageCache = [PageCache defaultPageCache];
//    NSArray *array = [pageCache.pageChacheArray objectAtIndex:course];
//    NSString *key;
//    if (chapter == -1) {
//        key = [array lastObject];
//    } else {
//        key = [array objectAtIndex:chapter];
//    }
//    [[NSUserDefaults standardUserDefaults] setInteger:self.currentSubject forKey:key];
//}

@end
