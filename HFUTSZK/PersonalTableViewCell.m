//
//  PersonalTableViewCell.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "PersonalTableViewCell.h"
#import "Masonry.h"

@implementation PersonalTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initCellTitle];
        [self initCellMark];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) initCellTitle {
    _cellTitle = [[UILabel alloc] init];
    _cellTitle.font = [UIFont systemFontOfSize:14];
    _cellTitle.textColor = [UIColor grayColor];
    [self addSubview:_cellTitle];
    _cellTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [_cellTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(52);
    }];
}

- (void) initCellMark {
    _cellMark = [[UIImageView alloc] init];
    _cellMark.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_cellMark];
    [_cellMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@32);
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
