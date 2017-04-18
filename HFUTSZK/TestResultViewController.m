//
//  TestResultViewController.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/26.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "TestResultViewController.h"
#import "Masonry.h"
#import "pop/POP.h"
#import "Define.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface TestResultViewController ()

@end

@implementation TestResultViewController

- (instancetype)initWithScore:(NSInteger)score {
    self= [super init];
    if (self != nil) {
        _score = score;
        
        [self initScrollView];
        
       
        [self initPie];
         [self initCircle];
        [self initScoreLabel];
        [self initPass];
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试结果";
    
    
    UIBarButtonItem *no = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = no;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPie {
    _pie = [[FanPicture alloc] initWithFrame:CGRectMake((kScreenWidth - 200) * 0.5f, 50, 200, 200) dataItems:@[[NSNumber numberWithInteger:_score/2], [NSNumber numberWithInteger:50-_score/2]] colorItems:@[FMRGBColor(40, 204, 59),FMRGBColor(167, 223, 228)]];
    [_scrollView addSubview:_pie];
    [_pie stroke];
}

- (void)initCircle {
    _circle = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-100)*0.5f, 100, 100, 100)];
    _circle.backgroundColor = FMColorWithHex(THEME_COLOR);
    _circle.layer.cornerRadius = 50.f;
    [_scrollView addSubview:_circle];
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

- (void)initCongratulation {
    _congratulation = [[UILabel alloc] init];
    if (_score<60) {
        _congratulation.text = @"不及格!";
        _congratulation.textColor = [UIColor redColor];
    } else {
        _congratulation.text = @"恭喜你!";
        _congratulation.textColor = [UIColor greenColor];
    }
    _congratulation.font = [UIFont systemFontOfSize:60];
    _congratulation.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_congratulation];
    [_congratulation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView.mas_centerX);
        make.top.equalTo(_scrollView.mas_top).offset(60);
    }];
}

- (void)initScoreLabel {
    _scoreLabel = [[UILabel alloc] init];
    _scoreLabel.text = [NSString stringWithFormat:@"分数：%ld", (long)_score];
    _scoreLabel.textColor = [UIColor whiteColor];
//    if (_score<60) {
//        _scoreLabel.textColor = [UIColor redColor];
//    } else {
//        _scoreLabel.textColor = [UIColor greenColor];
//    }
    _scoreLabel.font = [UIFont systemFontOfSize:18];
    _scoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_scoreLabel];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView.mas_centerX);
        make.centerY.equalTo(_circle.mas_centerY);
    }];
}

- (void)initPass {
    _pass = [UIButton buttonWithType:UIButtonTypeSystem];
    if (_score<60) {
        [_pass setTitle:@"继续加油" forState:UIControlStateNormal];
    } else {
        [_pass setTitle:@"回到首页" forState:UIControlStateNormal];
    }
    _pass.titleLabel.font = [UIFont systemFontOfSize:24];
    _pass.tintColor = [UIColor whiteColor];
    _pass.backgroundColor = FMColorWithHex(THEME_COLOR);
    _pass.layer.cornerRadius = 10.f;
    [_pass addTarget:self action:@selector(eventForPass:) forControlEvents:UIControlEventTouchUpInside];
    _pass.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_pass];
    [_pass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView.mas_centerX);
        make.top.equalTo(_circle.mas_bottom).offset(100);
        make.width.equalTo(_scrollView.mas_width).offset(-80);
        make.height.equalTo(@50);
    }];
    
}

- (void)eventForPass:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
