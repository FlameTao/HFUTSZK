//
//  AboutUsViewController.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/27.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "AboutUsViewController.h"
#import "Masonry.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
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
1.工大思政，针对学校采用机考形式期末考试，推出的手机刷题库的一款app\n\n\
2.学长都不复习了，加班给学弟学妹写完这个应用😂，去给个好评吧\n\n\
3.本应用由合肥工业大学移动互联创新实验室开发";
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
