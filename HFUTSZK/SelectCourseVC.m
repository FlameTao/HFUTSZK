//
//  SelectCourseVC.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/22.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "SelectCourseVC.h"
#import "Masonry.h"
#import "WrongSubjectViewController.h"
#import "CollectionViewController.h"

@interface SelectCourseVC ()

@end

@implementation SelectCourseVC

+ (SelectCourseVC*)selectWrongCourse {
    SelectCourseVC *vc = [[SelectCourseVC alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [vc initRightForRet];
    [vc initScrollView];
    [vc initSelectButton];
    return vc;
}

+ (SelectCourseVC*)selectCollectionCourse {
    SelectCourseVC *vc = [[SelectCourseVC alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [vc initRightForRet];
    [vc initScrollView];
    [vc initCollectionSelectButton];
    return vc;
    
}

- (void) initScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.contentSize = self.view.frame.size;
    [self.view addSubview:_scrollView];
}

- (void) initSelectButton {
    CGFloat width = self.view.frame.size.width;
    CGFloat spacing = (width-140)/3; // 间距，布局用的
    for (int i=0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"course_%d", i]] forState:UIControlStateNormal];
        [btn setTag:i];
        [btn addTarget:self action:@selector(gotoWrongSubject:) forControlEvents:UIControlEventTouchUpInside];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [_scrollView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@70);
            make.left.equalTo(_scrollView.mas_left).offset(spacing+(i%2)*(spacing+70));
            make.top.equalTo(_scrollView.mas_top).offset((i/2)*100+100);
        }];
        
    }
}

- (void) initCollectionSelectButton {
    CGFloat width = self.view.frame.size.width;
    CGFloat spacing = (width-140)/3; // 间距，布局用的
    for (int i=0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"course_%d", i]] forState:UIControlStateNormal];
        [btn setTag:i];
        [btn addTarget:self action:@selector(gotoCollectionSubject:) forControlEvents:UIControlEventTouchUpInside];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [_scrollView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@70);
            make.left.equalTo(_scrollView.mas_left).offset(spacing+(i%2)*(spacing+70));
            make.top.equalTo(_scrollView.mas_top).offset((i/2)*100+100);
        }];
        
    }
}

- (void) gotoWrongSubject:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSInteger course = btn.tag;
    WrongSubjectViewController *subjectVC = [[WrongSubjectViewController alloc] initWrongWithCourse:course];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subjectVC animated:YES];
    //self.hidesBottomBarWhenPushed = NO;
}

- (void) gotoCollectionSubject:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSInteger course = btn.tag;
    CollectionViewController *subjectVC = [[CollectionViewController alloc] initCollectionWithCourse:course];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subjectVC animated:YES];
    //self.hidesBottomBarWhenPushed = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择课程";
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ret"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(ret:)];
    self.navigationItem.leftBarButtonItem = itemleft;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)ret:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initRightForRet {
    _rightForRet = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ret:)];
    _rightForRet.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_rightForRet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
