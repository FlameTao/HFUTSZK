//
//  HomeView.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/12.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "HomeView.h"
#import "HomeTableViewCell.h"
#import "Masonry.h"

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.homeTabview = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    [self initHeaderView];
    self.homeTabview.tableFooterView = _headerView;
    [self addSubview:self.homeTabview];
    return self;
}

- (void) initHeaderView {
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _badge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"schoolName"]];
    [_headerView addSubview:_badge];
    _badge.translatesAutoresizingMaskIntoConstraints = NO;
    [_badge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerView.mas_centerX);
        make.top.equalTo(_headerView.mas_top).offset(10);
    }];
}


@end
