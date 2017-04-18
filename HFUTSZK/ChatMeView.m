//
//  ChatMeView.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "ChatMeView.h"
#import "Masonry.h"
#import "Define.h"

@implementation ChatMeView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        self.backgroundColor = [UIColor greenColor];
        _chatMeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width, self.frame.size.height-100) style:UITableViewStyleGrouped];
        [self initHeaderView];
       // _chatMeTableView.tableHeaderView = _headerView;
        [self addSubview:_chatMeTableView];
    }
    return self;
}

- (void)initHeaderView {
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
    _headerView.backgroundColor = FMRGBColor(239, 239, 244);
    [self addSubview:_headerView];
    _headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@100);
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
    }];
    _foreword = [[UILabel alloc] init];
    _foreword.text = @"如果使用过程中遇到有什么问题\n使用邮箱或者QQ联系，长按复制";
    _foreword.numberOfLines = 0;
    _foreword.lineBreakMode = NSLineBreakByWordWrapping;
    _foreword.textColor = [UIColor grayColor];
    _foreword.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_foreword];
    [_foreword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_headerView);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
