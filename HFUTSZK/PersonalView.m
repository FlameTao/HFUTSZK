//
//  PersonalView.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/12.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "PersonalView.h"
#import "Masonry.h"

@implementation PersonalView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor whiteColor];
        _personalTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        [self initHeaderView];
        _personalTableView.tableHeaderView = _headerView;
        [self addSubview:_personalTableView];
        
    }
    return self;
}


- (void) initHeaderView {
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _badge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"school"]];
    _badge.translatesAutoresizingMaskIntoConstraints = NO;
    [_headerView addSubview:_badge];
    [_badge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_headerView);
    }];
}

@end
