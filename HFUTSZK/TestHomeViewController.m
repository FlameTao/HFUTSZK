//
//  TestHomeViewController.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/25.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "TestHomeViewController.h"
#import "TestViewController.h"
#import "pop/POP.h"
#import "HFUTAlert.h"

@interface TestHomeViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation TestHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTestHomeView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTestHomeView {
    _testHomeView = [[TestHomeView alloc] initWithFrame:self.view.frame];
    [_testHomeView.btn0 addTarget:self action:@selector(eventForBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_testHomeView.btn1 addTarget:self action:@selector(eventForBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_testHomeView.btn2 addTarget:self action:@selector(eventForBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_testHomeView.btn3 addTarget:self action:@selector(eventForBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_testHomeView];
}

- (void)eventForBtn:(id)sender {
    UIButton *btn = sender;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat detal = 45*sqrt(2);
    CGFloat x = width/2;
    CGFloat y = 250;
    POPSpringAnimation *position0 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    position0.fromValue = [NSValue valueWithCGPoint:CGPointMake(x-detal, y-detal)];
    position0.toValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    position0.springSpeed = 0;
    [_testHomeView.btn0.layer pop_addAnimation:position0 forKey:@"btn0_go"];
    
    POPSpringAnimation *position1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    position1.fromValue = [NSValue valueWithCGPoint:CGPointMake(x+detal, y-detal)];
    position1.toValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    position1.springSpeed = 0;
    [_testHomeView.btn1.layer pop_addAnimation:position1 forKey:@"btn1_go"];
    
    POPSpringAnimation *position2 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    position2.fromValue = [NSValue valueWithCGPoint:CGPointMake(x-detal, y+detal)];
    position2.toValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    position2.springSpeed = 0;
    [_testHomeView.btn2.layer pop_addAnimation:position2 forKey:@"btn2_go"];
    
    POPSpringAnimation *position3 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    position3.fromValue = [NSValue valueWithCGPoint:CGPointMake(x+detal, y+detal)];
    position3.toValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    position3.springSpeed = 0;
    [_testHomeView.btn3.layer pop_addAnimation:position3 forKey:@"btn3_go"];
    
    TestViewController *testVC = [[TestViewController alloc] initWithTestCourse:btn.tag];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:testVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}


#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [HFUTPresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [HFUTDismissingAnimator new];
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
