//
//  TestHomeView.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/25.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "TestHomeView.h"
#import "Masonry.h"
#import "pop/POP.h"

@implementation TestHomeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor whiteColor];
        self.pagingEnabled = NO;
        self.scrollEnabled = YES;
        self.bounces = YES;
        self.alwaysBounceVertical = YES;
        self.contentSize = self.frame.size;
        
        
        [self initBtn];
        [self initImitate];
        
    }
    return self;
}

- (void)initImitate {
    _imitate = [UIButton buttonWithType:UIButtonTypeSystem];
    [_imitate setBackgroundImage:[UIImage imageNamed:@"moni"] forState:UIControlStateNormal];
    [_imitate setTitle:@"模拟考试" forState:UIControlStateNormal];
    _imitate.titleLabel.font = [UIFont systemFontOfSize:18];
    _imitate.tintColor = [UIColor whiteColor];
    [_imitate addTarget:self action:@selector(eventForImitate:) forControlEvents:UIControlEventTouchUpInside];
    _imitate.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_imitate];
    [_imitate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@100);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(200);
    }];
}

- (void)initBtn {
    _btn0 = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btn0 setBackgroundImage:[UIImage imageNamed:@"test_my"] forState:UIControlStateNormal];
    [_btn0 setTitle:@"马原" forState:UIControlStateNormal];
    _btn0.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn0.tintColor = [UIColor whiteColor];
    [_btn0 setTag:0];
    _btn0.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_btn0];
    [_btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@50);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(225);
    }];
    
    _btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"test_sx"] forState:UIControlStateNormal];
    [_btn1 setTitle:@"思修" forState:UIControlStateNormal];
    _btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn1.tintColor = [UIColor whiteColor];
    [_btn1 setTag:1];
    _btn1.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_btn1];
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@50);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(225);
    }];
    
    _btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"test_mzt"] forState:UIControlStateNormal];
    [_btn2 setTitle:@"毛中特" forState:UIControlStateNormal];
    _btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn2.tintColor = [UIColor whiteColor];
    [_btn2 setTag:2];
    _btn2.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_btn2];
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@50);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(225);
    }];
    
    _btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btn3 setBackgroundImage:[UIImage imageNamed:@"test_jds"] forState:UIControlStateNormal];
    [_btn3 setTitle:@"近代史" forState:UIControlStateNormal];
    _btn3.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn3.tintColor = [UIColor whiteColor];
    [_btn3 setTag:3];
    _btn3.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_btn3];
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@50);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(225);
    }];
}

- (void)btnAnimation {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat detal = 45*sqrt(2);
    CGFloat x = width/2;
    CGFloat y = 250;
    POPSpringAnimation *position0 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    position0.fromValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    position0.toValue = [NSValue valueWithCGPoint:CGPointMake(x-detal, y-detal)];
    position0.springSpeed = 0;
    [_btn0.layer pop_addAnimation:position0 forKey:@"btn0_come"];
    
    POPSpringAnimation *position1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    position1.fromValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    position1.toValue = [NSValue valueWithCGPoint:CGPointMake(x+detal, y-detal)];
    position1.springSpeed = 0;
    [_btn1.layer pop_addAnimation:position1 forKey:@"btn1_come"];
    
    POPSpringAnimation *position2 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    position2.fromValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    position2.toValue = [NSValue valueWithCGPoint:CGPointMake(x-detal, y+detal)];
    position2.springSpeed = 0;
    [_btn2.layer pop_addAnimation:position2 forKey:@"btn2_come"];
    
    POPSpringAnimation *position3 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    position3.fromValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    position3.toValue = [NSValue valueWithCGPoint:CGPointMake(x+detal, y+detal)];
    position3.springSpeed = 0;
    [_btn3.layer pop_addAnimation:position3 forKey:@"btn3_come"];
}

- (void)eventForImitate:(id)sender {
    [self btnAnimation];
}




@end
