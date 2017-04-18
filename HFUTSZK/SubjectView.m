//
//  SubjectView.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "SubjectView.h"
#import "NSString+Extent.h"
#import "Masonry.h"
#import "Define.h"
#import "Option.h"

@implementation SubjectView

- (void)showSubject:(SubjectModel *)subject {
    self.pagingEnabled = NO;
    self.scrollEnabled = YES;
    self.bounces = YES;
    self.alwaysBounceVertical = YES;
    self.contentSize = CGSizeMake(self.frame.size.width, [self height:subject]);
    if (_subjectType == nil) {
        _subjectType = [[UILabel alloc] init];
        
    }
    if (subject.subjectType == 1) {
        _subjectType.text = @"判断题";
    } else if (subject.subjectType == 2) {
        _subjectType.text = @"单选题";
    } else {
        _subjectType.text = @"多选题";
    }
    _subjectType.textColor = FMColorWithHex(THEME_COLOR);
    _subjectType.font = [UIFont systemFontOfSize:10];
    _subjectType.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_subjectType];
    [_subjectType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(20);
    }];
    
    if (_subjectContent == nil) {
        _subjectContent = [[UILabel alloc] init];
        
    }
    NSString *sub = @"        ";
    _subjectContent.text = [sub stringByAppendingString:subject.subjectContent];
    _subjectContent.font = [UIFont systemFontOfSize:18];
    _subjectContent.numberOfLines = 0;
    _subjectContent.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_subjectContent.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10]; //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_subjectContent.text length])]; _subjectContent.attributedText = attributedString;
    [_subjectContent sizeToFit];
    
    _subjectContent.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_subjectContent];
    [_subjectContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(20);
        make.width.equalTo(self.mas_width).offset(-20);
    }];
    
    if (subject.subjectType == 1) {
        [self initOpA:subject.subjectOptionA];
        [self initOpB:subject.subjectOptionB];
        [_opC removeFromSuperview];
        [_opD removeFromSuperview];
        [_commit removeFromSuperview];
    } else if(subject.subjectType == 2) {
        [self initOpA:subject.subjectOptionA];
        [self initOpB:subject.subjectOptionB];
        [self initOpC:subject.subjectOptionC];
        [self initOpD:subject.subjectOptionD];
        [_commit removeFromSuperview];
    } else {
        [self initOpA:subject.subjectOptionA];
        [self initOpB:subject.subjectOptionB];
        [self initOpC:subject.subjectOptionC];
        [self initOpD:subject.subjectOptionD];
        [self initCommit];
    }
    _moreselectAnswer = [[NSString alloc] init];
    [self setNeedsLayout];
}

- (void)initOpA:(NSString*)option {
    if (_opA != nil) {
        [_opA removeFromSuperview];
    }
    _opA = [Option optionWithOption:option Order:@"a"];
    [_opA setTag:0];
    _opA.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_opA];
    [_opA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [option heightWithText:option font:[UIFont systemFontOfSize:18] width:width-57];
        if (height <= 24) {
            height = 44;
        } else {
            height += 20;
        }
        make.height.equalTo([NSNumber numberWithFloat:height]);
        make.top.equalTo(_subjectContent.mas_bottom).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (void)initOpB:(NSString*)option {
    if (_opB != nil) {
        [_opB removeFromSuperview];
    }
    _opB = [Option optionWithOption:option Order:@"b"];
    [_opB setTag:1];
    _opB.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_opB];
    [_opB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [option heightWithText:option font:[UIFont systemFontOfSize:18] width:width-57];
        if (height <= 24) {
            height = 44;
        } else {
            height += 20;
        }
        make.height.equalTo([NSNumber numberWithFloat:height]);
        make.top.equalTo(_opA.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (void)initOpC:(NSString*)option {
    if (_opC != nil) {
        [_opC removeFromSuperview];
    }
    _opC = [Option optionWithOption:option Order:@"c"];
    [_opC setTag:2];
    _opC.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_opC];
    [_opC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [option heightWithText:option font:[UIFont systemFontOfSize:18] width:width-57];
        if (height <= 24) {
            height = 44;
        } else {
            height += 20;
        }
        make.height.equalTo([NSNumber numberWithFloat:height]);
        make.top.equalTo(_opB.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (void)initOpD:(NSString*)option {
    if (_opD != nil) {
        [_opD removeFromSuperview];
    }
    _opD = [Option optionWithOption:option Order:@"d"];
    [_opD setTag:3];
    _opD.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_opD];
    [_opD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [option heightWithText:option font:[UIFont systemFontOfSize:18] width:width-57];
        if (height <= 24) {
            height = 44;
        } else {
            height += 20;
        }
        make.height.equalTo([NSNumber numberWithFloat:height]);
        make.top.equalTo(_opC.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (void)initCommit {
    if (_commit != nil) {
        [_commit removeFromSuperview];
    }
    _commit = [UIButton buttonWithType:UIButtonTypeSystem];
    _commit.layer.cornerRadius = 10.f;
    _commit.backgroundColor = FMColorWithHex(THEME_COLOR);
    _commit.titleLabel.font = [UIFont systemFontOfSize:18];
    [_commit setTitle:@"提交" forState:UIControlStateNormal];
    _commit.tintColor = [UIColor whiteColor];
    _commit.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_commit];
    [_commit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.height.equalTo(@50);
        make.top.equalTo(_opD.mas_bottom).offset(50);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (CGFloat)height:(SubjectModel *)subject {
    CGFloat height = 40;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIFont *font = [UIFont systemFontOfSize:18];
    CGFloat contentHeight = [subject.subjectContent heightWithText:subject.subjectContent font:font width:width-57];
    if (contentHeight > 100) {
        if (contentHeight > 200) {
            if (contentHeight > 300) {
                contentHeight += 120;
            } else {
                contentHeight += 80;
            }
        } else {
            contentHeight += 40;
        }
    }
    CGFloat optionHeightA = [subject.subjectOptionA heightWithText:subject.subjectOptionA font:font width:width-57];
    CGFloat optionHeightB = [subject.subjectOptionB heightWithText:subject.subjectOptionB font:font width:width-57];
    if (optionHeightA <= 24) {
        optionHeightA = 44;
    } else {
        optionHeightA += 20;
    }
    if (optionHeightB <= 24) {
        optionHeightB = 44;
    } else {
        optionHeightB += 20;
    }
    CGFloat optionHeightC = 0;
    CGFloat optionHeightD = 0;
    if (subject.subjectType != 1) {
        optionHeightC = [subject.subjectOptionC heightWithText:subject.subjectOptionC font:font width:width-57];
        if (optionHeightC <= 24) {
            optionHeightC = 44;
        } else {
            optionHeightC += 20;
        }
        optionHeightD = [subject.subjectOptionD heightWithText:subject.subjectOptionD font:font width:width-57];
        if (optionHeightD <= 24) {
            optionHeightD = 44;
        } else {
            optionHeightD += 20;
        }
    }
    height = height + contentHeight + optionHeightA + optionHeightB + optionHeightC + optionHeightD + 30;
    if (subject.subjectType == 3) {
        height += 100;
    }
    return height;
}

- (void) closeOpUse {
    _opA.userInteractionEnabled = NO;
    _opB.userInteractionEnabled = NO;
    _opC.userInteractionEnabled = NO;
    _opD.userInteractionEnabled = NO;
    _commit.userInteractionEnabled = NO;

    //self.userInteractionEnabled = NO;
}

- (void) openOpUse {
    _opA.userInteractionEnabled = YES;
    _opB.userInteractionEnabled = YES;
    _opC.userInteractionEnabled = YES;
    _opD.userInteractionEnabled = YES;
    _commit.userInteractionEnabled = YES;
    //self.userInteractionEnabled = YES;
}

- (void) successMarkWithSelectedOpsition:(NSInteger)selectedOpsition subjectType:(NSInteger)subjectType {
    if (subjectType == 1) {                 // 判断题
        if (selectedOpsition == 0) {
            _opA.optionMark.image = [UIImage imageNamed:@"ted"];
        } else {
            _opB.optionMark.image = [UIImage imageNamed:@"ted"];
        }
    } else if (subjectType == 2) {          // 单选题
        if (selectedOpsition == 0) {
            _opA.optionMark.image = [UIImage imageNamed:@"ted"];
        } else if (selectedOpsition == 1) {
            _opB.optionMark.image = [UIImage imageNamed:@"ted"];
        } else if (selectedOpsition == 2) {
            _opC.optionMark.image = [UIImage imageNamed:@"ted"];
        } else {
            _opD.optionMark.image = [UIImage imageNamed:@"ted"];
        }
    } else {                                // 多选题
        
    }
}

- (void) failureMarkWithSelectedOpsition:(NSInteger)selectedOpstion subjectModel:(SubjectModel *)model {
    if (model.subjectType == 1) {
        if (selectedOpstion == 0) {
            _opA.optionMark.image = [UIImage imageNamed:@"fed"];
            _opB.optionMark.image = [UIImage imageNamed:@"ted"];
        } else {
            _opA.optionMark.image = [UIImage imageNamed:@"ted"];
            _opB.optionMark.image = [UIImage imageNamed:@"fed"];
        }
    } else if (model.subjectType == 2) {
        if (selectedOpstion == 0) {
            _opA.optionMark.image = [UIImage imageNamed:@"fed"];
        } else if (selectedOpstion == 1) {
            _opB.optionMark.image = [UIImage imageNamed:@"fed"];
        } else if (selectedOpstion == 2) {
            _opC.optionMark.image = [UIImage imageNamed:@"fed"];
        } else {
            _opD.optionMark.image = [UIImage imageNamed:@"fed"];
        }
        if ([model.subjectAnswer isEqualToString:@"A"]) {
            _opA.optionMark.image = [UIImage imageNamed:@"ted"];
        } else if ([model.subjectAnswer isEqualToString:@"B"]) {
            _opB.optionMark.image = [UIImage imageNamed:@"ted"];
        } else if ([model.subjectAnswer isEqualToString:@"C"]) {
            _opC.optionMark.image = [UIImage imageNamed:@"ted"];
        } else {
            _opD.optionMark.image = [UIImage imageNamed:@"ted"];
        }
    }
}

- (void)moreSelectSuccess {
    if (_opA.selected == YES) {
        _opA.optionMark.image = [UIImage imageNamed:@"ted"];
    }
    if (_opB.selected == YES) {
        _opB.optionMark.image = [UIImage imageNamed:@"ted"];
    }
    if (_opC.selected == YES) {
        _opC.optionMark.image = [UIImage imageNamed:@"ted"];
    }
    if (_opD.selected == YES) {
        _opD.optionMark.image = [UIImage imageNamed:@"ted"];
    }
}

- (void)moreSelectFailureWithSubjectModel:(SubjectModel *)model {
    if (_opA.selected == YES) {
        _opA.optionMark.image = [UIImage imageNamed:@"fed"];
    }
    if (_opB.selected == YES) {
        _opB.optionMark.image = [UIImage imageNamed:@"fed"];
    }
    if (_opC.selected == YES) {
        _opC.optionMark.image = [UIImage imageNamed:@"fed"];
    }
    if (_opD.selected == YES) {
        _opD.optionMark.image = [UIImage imageNamed:@"fed"];
    }
    if ([model.subjectAnswer containsString:@"A"]) {
        _opA.optionMark.image = [UIImage imageNamed:@"ted"];
    }
    if ([model.subjectAnswer containsString:@"B"]) {
        _opB.optionMark.image = [UIImage imageNamed:@"ted"];
    }
    if ([model.subjectAnswer containsString:@"C"]) {
        _opC.optionMark.image = [UIImage imageNamed:@"ted"];
    }
    if ([model.subjectAnswer containsString:@"D"]) {
        _opD.optionMark.image = [UIImage imageNamed:@"ted"];
    }
}


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    
//    _beginPoint = [touch locationInView:self];
//    
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    
//    CGPoint nowPoint = [touch locationInView:self];
//    
//    float offsetX = nowPoint.x - _beginPoint.x;
//    
//    self.center = CGPointMake(self.center.x + offsetX, self.center.y);
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
