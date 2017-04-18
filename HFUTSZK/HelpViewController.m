//
//  HelpViewController.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/27.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "HelpViewController.h"
#import "Masonry.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用帮助";
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
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+100);
    [self.view addSubview:_scrollView];
}

- (void)initContent {
    _content = [[UILabel alloc] init];
    _content.text = @"\
1.首页四门思政课点击进入后选择章节，顺序练习，在练习界面右上角有个👀的按钮，点击可切换浏览模式或者是练习模式。章节练习不会记录你做过的题目，方便大家随时切回重新练习。\n\n\
2.错题会自动记录在我的错题中，随时可进入查看、删除\n\n\
3.工具栏左下角收藏按钮，可在任何做题地方收藏题目，并可在我的收集中查看、删除\n\n\
4.模拟考试会按类型定量随机抽取题目练习，不与学校考试机制相同，可以当成随机练习使用\n\n\
5.工具栏记录✅❎题目的数量暂时只在模拟测试下有效";
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
