//
//  SelectChapterVC.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/19.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "SelectChapterVC.h"
#import "Masonry.h"
#import "SubjectViewController.h"

@interface SelectChapterVC ()

@end

@implementation SelectChapterVC

+ (SelectChapterVC*)selectWithCourse:(NSInteger)course {
    SelectChapterVC *vc = [[SelectChapterVC alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    
    vc.course = course;
    [vc initScrollView];
    [vc initCourseName];
    
    [vc initLine];
    [vc initViewWithCourse:course];
    [vc initRightForRet];
    
    return vc;
}

- (void)initScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.contentSize = self.view.frame.size;
    [self.view addSubview:_scrollView];
}

- (void)initViewWithCourse:(NSInteger)course {
    CGFloat width = self.view.frame.size.width;
    CGFloat spacing = (width-150)/4; // 间距，布局用的
    if (course == 0) {
        for (int i=0; i<9; i++) { // 这个数字根据数据库来的
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn = [UIButton buttonWithType:UIButtonTypeSystem];
            if (i == 8) {
                [btn setBackgroundImage:[UIImage imageNamed:@"selectall_mks"] forState:UIControlStateNormal];
                [btn setTag:100]; // tag 表示选取的章节， 100表示选取全部
            } else {
                [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"select%d_mks", i]] forState:UIControlStateNormal];
                [btn setTag:i];
            }
            [btn addTarget:self action:@selector(gotoSubject:) forControlEvents:UIControlEventTouchUpInside];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [_scrollView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_scrollView.mas_left).offset(spacing+(i%3)*(spacing+50));
                make.top.equalTo(self.line.mas_top).offset((i/3)*70+20);
                make.width.and.height.equalTo(@50);
            }];
        }
    } else if (course == 1) {
        for (int i=0; i<9; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn = [UIButton buttonWithType:UIButtonTypeSystem];
            if (i == 8) {
                [btn setBackgroundImage:[UIImage imageNamed:@"selectall_sx"] forState:UIControlStateNormal];
                [btn setTag:100];
            } else {
                [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"select%d_sx", i]] forState:UIControlStateNormal];
                [btn setTag:i];
            }
            [btn addTarget:self action:@selector(gotoSubject:) forControlEvents:UIControlEventTouchUpInside];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [_scrollView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_scrollView.mas_left).offset(spacing+(i%3)*(spacing+50));
                make.top.equalTo(self.line.mas_top).offset((i/3)*70+20);
                make.width.and.height.equalTo(@50);
            }];
        }
    } else if (course == 2) {
        for (int i=0; i<13; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn = [UIButton buttonWithType:UIButtonTypeSystem];
            if (i == 12) {
                [btn setBackgroundImage:[UIImage imageNamed:@"selectall_mzt"] forState:UIControlStateNormal];
                [btn setTag:100];
            } else {
                [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"select%d_mzt", i+1]] forState:UIControlStateNormal];
                [btn setTag:i+1];
            }
            [btn addTarget:self action:@selector(gotoSubject:) forControlEvents:UIControlEventTouchUpInside];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [_scrollView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_scrollView.mas_left).offset(spacing+(i%3)*(spacing+50));
                make.top.equalTo(self.line.mas_top).offset((i/3)*70+20);
                make.width.and.height.equalTo(@50);
            }];
        }
    } else {
        for (int i=0; i<8; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn = [UIButton buttonWithType:UIButtonTypeSystem];
            if (i == 7) {
                [btn setBackgroundImage:[UIImage imageNamed:@"selectall_jds"] forState:UIControlStateNormal];
                [btn setTag:100];
            } else {
                [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"select%d_jds", i+1]] forState:UIControlStateNormal];
                [btn setTag:i+1];
            }
            [btn addTarget:self action:@selector(gotoSubject:) forControlEvents:UIControlEventTouchUpInside];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [_scrollView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_scrollView.mas_left).offset(spacing+(i%3)*(spacing+50));
                make.top.equalTo(self.line.mas_top).offset((i/3)*70+20);
                make.width.and.height.equalTo(@50);
            }];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择章节";
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ret"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(ret:)];
    self.navigationItem.leftBarButtonItem = itemleft;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initCourseName {
    _courseName = [[UILabel alloc] init];
    _courseName.textColor = [UIColor grayColor];
    _courseName.lineBreakMode = NSLineBreakByWordWrapping;
    _courseName.numberOfLines = 0;
    if (_course == 0) {
        _courseName.text = @"马克思主义基本原理概论";
    } else if (_course == 1) {
        _courseName.text = @"思想道德修养与法律基础";
    } else if (_course == 2) {
        _courseName.text = @"毛泽东思想和中国特色\n社会主义理论体系概论";
    } else {
        _courseName.text = @"中国近代史纲要";
    }
    _courseName.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_courseName];
    [_courseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView.mas_centerX);
        make.top.equalTo(_scrollView.mas_top).offset(10);
    }];
}

- (void)initLine {
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor grayColor];
    _line.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView.mas_centerX);
        make.height.equalTo(@0.5);
        make.width.equalTo(_scrollView.mas_width).offset(-20);
        make.top.equalTo(self.courseName.mas_bottom).offset(10);
    }];
}

- (void)initRightForRet {
    _rightForRet = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ret:)];
    _rightForRet.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_rightForRet];
}


#pragma mark - 响应事件
- (void)ret:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoSubject:(id)sender {
    UIButton *btn = sender;
    NSInteger chapter = btn.tag;
    SubjectViewController *subjectVC;
    if (chapter == 100) {
        subjectVC = [[SubjectViewController alloc] initWithCourse:_course];
    } else {
        subjectVC = [[SubjectViewController alloc] initWithCourse:_course Chapter:chapter];
    }
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subjectVC animated:YES];
    //self.hidesBottomBarWhenPushed = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
