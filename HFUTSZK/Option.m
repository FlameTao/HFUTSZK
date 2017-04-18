//
//  Option.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "Option.h"
#import "Masonry.h"
#import "NSString+Extent.h"

@implementation Option

+ (Option*)optionWithOption:(NSString *)option Order:(NSString *)order {
    
    Option *myoption = [[Option alloc] init];
    myoption.backgroundColor = [UIColor whiteColor];
    myoption.optionMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:order]];
    [myoption addSubview:myoption.optionMark];
    myoption.optionMark.translatesAutoresizingMaskIntoConstraints = NO;
    [myoption.optionMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myoption.mas_left).offset(10);
        make.top.equalTo(myoption.mas_top).offset(10);
    }];
    
    myoption.option = [[UILabel alloc] init];
    myoption.option.text = option;
    myoption.option.font = [UIFont systemFontOfSize:18];
    myoption.option.numberOfLines = 0;
    myoption.option.lineBreakMode = NSLineBreakByWordWrapping;
    myoption.option.translatesAutoresizingMaskIntoConstraints = NO;
    [myoption addSubview:myoption.option];
    [myoption.option mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myoption.mas_top).offset(10);
        make.left.equalTo(myoption.optionMark.mas_right).offset(10);
        make.width.equalTo(myoption.mas_width).offset(-57);
    }];
    
    myoption.tapForCheck = [[UITapGestureRecognizer alloc] init];
    myoption.tapForCheck.numberOfTapsRequired = 1;
    [myoption addGestureRecognizer:myoption.tapForCheck];
    myoption.selected = NO;
    return myoption;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
