//
//  ExplanationViewController.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/27.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "ExplanationViewController.h"
#import "Masonry.h"

@interface ExplanationViewController ()

@end

@implementation ExplanationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"说明";
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ret"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(ret:)];
    self.navigationItem.leftBarButtonItem = itemleft;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initScrollView];
    [self initContent];
    
    UISwipeGestureRecognizer *rightForRet = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ret:)];
    rightForRet.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightForRet];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)initContent {
    _content = [[UILabel alloc] init];
    _content.text = @"\
1.题库更新于2016.06.19，可能和学校实时有点差别\n\n\
2.模拟测试只是按类型随机抽取定量题目练习，并不保证和学校考试机制相同，大家可以当成随机练习使用\n\n\
3.个人精力有限，难免会有一些bug没有发现，若你在使用过程中遇到什么问题可以通过邮箱告知，方便修改\n\n\
4.本应用完全单机，不涉及隐私，不涉及网络，可放心使用";
    _content.font = [UIFont systemFontOfSize:18];
    _content.lineBreakMode = NSLineBreakByWordWrapping;
    _content.numberOfLines = 0;
    _content.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView.mas_centerX);
        make.width.equalTo(_scrollView.mas_width).offset(-40);
        make.top.equalTo(_scrollView.mas_top).offset(60);
    }];
}

- (void)ret:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
