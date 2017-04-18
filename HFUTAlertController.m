//
//  HFUTAlertController.m
//  Demo
//
//  Created by Flame on 2017/2/9.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "HFUTAlertController.h"
#import "Masonry.h"

@interface HFUTAlertController ()

@end

@implementation HFUTAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (HFUTAlertController*)alertWithTitle:(NSString *)title message:(NSString *)message style:(AlertStyle)style {
    HFUTAlertController* hfutalert = [[HFUTAlertController alloc] init];
    hfutalert.alertStyle = style;
    hfutalert.modalPresentationStyle = UIModalPresentationCustom;
    hfutalert.view.backgroundColor = [UIColor whiteColor];
    hfutalert.view.layer.cornerRadius = 5.f;
    [hfutalert configAlertWithTitle:title message:message];
    return hfutalert;
}

+ (HFUTAlertController*)alertWithMessage:(NSString *)message style:(AlertStyle)style {
    HFUTAlertController* hfutalert = [[HFUTAlertController alloc] init];
    hfutalert.alertStyle = style;
    hfutalert.modalPresentationStyle = UIModalPresentationCustom;
    hfutalert.view.backgroundColor = [UIColor whiteColor];
    hfutalert.view.layer.cornerRadius = 5.f;
    return hfutalert;
}

- (void)configAlertWithTitle:(NSString*)title message:(NSString*)message {
    if (self.alertStyle == AlertStyleInfoWithSingleButton || self.alertStyle == AlertStyleDefaultWithSingleButton || self.alertStyle == AlertStyleSuccessWithSingleButton || self.alertStyle == AlertStyleFailureWithSingleButton) {
        self.view.frame = CGRectMake(0, 0, FMScreenWidth*4/5, FMScreenWidth*3/5);
        self.view.center = CGPointMake(FMScreenWidth*0.5, -FMScreenHeight*0.5);
        [self configDefaultButton];
        [self configStyleMarkBG];
        [self configStyleMark];
        [self configTitleLabel:title];
        [self configMessageLabel:message];
    } else {
        self.view.frame = CGRectMake(0, 0, FMScreenWidth*4/5, FMScreenWidth*3/5);
        self.view.center = CGPointMake(FMScreenWidth*0.5, -FMScreenHeight*0.5);
        [self configDefaultButton];
        [self configCancelButton];
        [self configStyleMarkBG];
        [self configStyleMark];
        [self configTitleLabel:title];
        [self configMessageLabel:message];
    }
}

- (void)configDefaultButton {
    //defaultButton
    _defaultButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _defaultButton.layer.cornerRadius = 5.f;
    if (_alertStyle == AlertStyleSuccessWithSingleButton) {
        _defaultButton.backgroundColor = FMGreen;
    } else if (_alertStyle == AlertStyleFailureWithSingleButton) {
        _defaultButton.backgroundColor = FMRed;
    } else if (_alertStyle == AlertStyleInfoWithSingleButton) {
        _defaultButton.backgroundColor = FMGray;
    } else {
        _defaultButton.backgroundColor = FMGreen;
    }
    [_defaultButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [_defaultButton setTintColor:[UIColor whiteColor]];
    _defaultButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _defaultButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_defaultButton setTitle:@"确定" forState:UIControlStateNormal];
    [_defaultButton addTarget:self action:@selector(defaultButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_defaultButton];
    _defaultButton.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.alertStyle == AlertStyleInfoWithSingleButton || self.alertStyle == AlertStyleDefaultWithSingleButton || self.alertStyle == AlertStyleSuccessWithSingleButton || self.alertStyle == AlertStyleFailureWithSingleButton) {
        [_defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).with.offset(15);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
            make.right.equalTo(self.view.mas_right).with.offset(-15);
            make.height.equalTo(self.view.mas_height).with.multipliedBy(0.25);
        }];
    } else {
        [_defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_centerX).with.offset(8);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
            make.right.equalTo(self.view.mas_right).with.offset(-15);
            make.height.equalTo(self.view.mas_height).with.multipliedBy(0.25);
        }];
    }
}

- (void)configCancelButton {
    _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelButton.layer.cornerRadius = 5.f;
    _cancelButton.backgroundColor = FMRed;
    [_cancelButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setTintColor:[UIColor whiteColor]];
    _cancelButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:_cancelButton];
    _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
        make.right.equalTo(self.view.mas_centerX).with.offset(-8);
        make.height.equalTo(self.view.mas_height).with.multipliedBy(0.25);
    }];
}

- (void)configStyleMarkBG {
    //styleMarkBG
    _styleMarkBG = [[UIView alloc] init];
    if (_alertStyle == AlertStyleSuccessWithSingleButton || _alertStyle == AlertStyleSuccessWithDoubleButton) {
        _styleMarkBG.backgroundColor = FMGreen;
    } else if (_alertStyle == AlertStyleFailureWithSingleButton || _alertStyle == AlertStyleFailureWithDoubleButton) {
        _styleMarkBG.backgroundColor = FMRed;
    } else if (_alertStyle == AlertStyleInfoWithSingleButton || _alertStyle == AlertStyleInfoWithDoubleButton) {
        _styleMarkBG.backgroundColor = FMGray;
    } else {
        _styleMarkBG.backgroundColor = FMGreen;
    }
    _styleMarkBG.layer.cornerRadius = 0.f;
    [self.view addSubview:_styleMarkBG];
    _styleMarkBG.translatesAutoresizingMaskIntoConstraints = NO;
    [_styleMarkBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).with.multipliedBy(0);
        make.height.equalTo(self.view.mas_width).with.multipliedBy(0);
        make.centerY.equalTo(self.view.mas_top);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (void)configStyleMark {
    //styleMark
    NSString *imageName;
    if (self.alertStyle == AlertStyleSuccessWithSingleButton || self.alertStyle == AlertStyleSuccessWithDoubleButton) {
        imageName = @"checkMark.png";
    } else if (self.alertStyle == AlertStyleFailureWithSingleButton || self.alertStyle == AlertStyleFailureWithDoubleButton) {
        imageName = @"crossMark.png";
    } else {
        imageName = @"info.png";
    }
    self.styleMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    self.styleMark.contentMode = UIViewContentModeScaleAspectFit;
    self.styleMark.layer.cornerRadius = 0.f;
    [self.view addSubview:self.styleMark];
    self.styleMark.translatesAutoresizingMaskIntoConstraints = NO;
    [self.styleMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).with.multipliedBy(0);
        make.height.equalTo(self.view.mas_width).with.multipliedBy(0);
        make.centerY.equalTo(self.view.mas_top);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (void)configTitleLabel:(NSString*)title {
    //titleLabel
    CGFloat  deviation = 0.f;
    if (_alertStyle == AlertStyleDefaultWithSingleButton || _alertStyle == AlertStyleDefaultWithDoubleButton) {
        deviation = -20.f;
    }
    CGFloat width = CGRectGetWidth(self.view.bounds);
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.text = title;
    [self.view addSubview:_titleLabel];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(width*0.15+10+deviation);
        make.centerX.equalTo(self.view);
    }];
}

- (void)configMessageLabel:(NSString*)message {
    //message
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.numberOfLines = 0;
    _messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.font = [UIFont systemFontOfSize:15];
    _messageLabel.text = message;
    [self.view addSubview:_messageLabel];
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_defaultButton.mas_top).offset(-5);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
    }];
}

- (void)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)defaultButtonAciton:(id)sender {
    _successCompletion();
}

- (void)cancelButtonAction:(id)sender {
    _failureCompletion();
}

- (void)setDefaultCompletion:(Completion)completion {
    _successCompletion = completion;
}

- (void)setCancelCompletion:(Completion)completion {
    _failureCompletion = completion;
}

- (void)setDefaultButtonTitle:(NSString *)title {
    [_defaultButton setTitle:title forState:UIControlStateNormal];
}

- (void)setCancelButtonTitle:(NSString *)title {
    [_cancelButton setTitle:title forState:UIControlStateNormal];
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
