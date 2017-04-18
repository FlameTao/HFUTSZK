//
//  HomeTableViewCell.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/12.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "Masonry.h"
#import "pop/POP.h"

@implementation HomeTableViewCell

int status = 0;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self configCourseName];
//        [self configLine];
//        [self configCourseImage];
//        [self configPractice];
//        [self configByChapter];
//        [self configByType];
//        //[self configWatch];
//    }
//    return self;
//}

- (instancetype) init {
    if (self = [super init]) {
        [self configCourseName];
        [self configLine];
        [self configCourseImage];
        //[self configPractice];
        //[self configByChapter];
        //[self configByType];
    }
    return self;
}

- (void)configCourseName {
    _courseName = [[UILabel alloc] init];
    _courseName.textColor = [UIColor grayColor];
    _courseName.lineBreakMode = NSLineBreakByWordWrapping;
    _courseName.numberOfLines = 0;
    _courseName.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_courseName];
    [_courseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(10);
    }];
}

- (void)configLine {
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor grayColor];
    _line.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@0.5);
        make.width.equalTo(self.mas_width).offset(-20);
        make.top.equalTo(self.courseName.mas_bottom).offset(10);
    }];
}

- (void)configCourseImage {
    _courseImage = [[UIImageView alloc] init];
    //_courseImage.backgroundColor = [UIColor greenColor];
    _courseImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_courseImage];
    [_courseImage mas_makeConstraints:^(MASConstraintMaker *make) {
        //CGFloat width = self.frame.size.width;
//        make.centerX.equalTo(self.mas_centerX);
//        make.width.equalTo([NSNumber numberWithFloat:(width-20)]);
//        make.height.equalTo([NSNumber numberWithFloat:(width-20)*2/3]);
//        make.top.equalTo(self.line.mas_bottom).offset(30);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width).offset(-20);
        make.height.equalTo(self.courseImage.mas_width).multipliedBy(2.0/3);
        make.top.equalTo(self.line.mas_bottom).offset(30);
    }];
}

- (void)configPractice {
    _practice = [UIButton buttonWithType:UIButtonTypeSystem];
    _practice.layer.cornerRadius = 10.f;
    [_practice setTitle:@"练习" forState:UIControlStateNormal];
    _practice.tintColor = [UIColor whiteColor];
    _practice.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_practice addTarget:self action:@selector(popSelect:) forControlEvents:UIControlEventTouchUpInside];
    _practice.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_practice];
    [_practice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
    }];
}

- (void)configByChapter {
    _byChapter = [UIButton buttonWithType:UIButtonTypeSystem];
    _byChapter.layer.cornerRadius = 10.f;
    [_byChapter setTitle:@"按章节练习" forState:UIControlStateNormal];
    _byChapter.tintColor = [UIColor whiteColor];
    _byChapter.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _byChapter.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_byChapter];
    [_byChapter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_practice.mas_top).offset(-10);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
    }];
    _byChapter.layer.opacity = 0.f;
}

- (void)configByType {
    _byType = [UIButton buttonWithType:UIButtonTypeSystem];
    _byType.layer.cornerRadius = 10.f;
    [_byType setTitle:@"按题型练习" forState:UIControlStateNormal];
    _byType.tintColor = [UIColor whiteColor];
    _byType.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _byType.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_byType];
    [_byType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_byChapter.mas_top).offset(-10);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@50);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
    }];
    _byType.layer.opacity = 0.f;
}

- (void)configWatch {
    _watch = [UIButton buttonWithType:UIButtonTypeSystem];
    _watch.layer.cornerRadius = 40.f;
    [_watch setTitle:@"浏览" forState:UIControlStateNormal];
    _watch.tintColor = [UIColor whiteColor];
    _watch.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _watch.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_watch];
    [_watch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.left.equalTo(self.mas_left).offset(50);
        make.width.and.height.equalTo(@80);
    }];
}

- (void)popSelect:(id)sender {
    _practice.userInteractionEnabled = NO;
    if (status == 0) {
        POPSpringAnimation *pop0 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        pop0.toValue = [NSNumber numberWithFloat:1.f];
        [pop0 setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            if (finished == YES) {
                POPSpringAnimation *pop1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
                pop1.toValue = [NSNumber numberWithFloat:1.f];
                [pop1 setCompletionBlock:^(POPAnimation *animation1, BOOL finished1) {
                    if (finished1 == YES) {
                        status = 1;
                        _practice.userInteractionEnabled = YES;
                    }
                }];
                [_byType.layer pop_addAnimation:pop1 forKey:@"pop1_come"];
            }
        }];
        [_byChapter.layer pop_addAnimation:pop0 forKey:@"pop0_come"];
    } else {
        POPSpringAnimation *pop0 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        pop0.toValue = [NSNumber numberWithFloat:0.f];
        [pop0 setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            if (finished == YES) {
                POPSpringAnimation *pop1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
                pop1.toValue = [NSNumber numberWithFloat:0.f];
                [pop1 setCompletionBlock:^(POPAnimation *animation1, BOOL finished1) {
                    if (finished1 == YES) {
                        status = 0;
                        _practice.userInteractionEnabled = YES;
                    }
                }];
                
                [_byChapter.layer pop_addAnimation:pop1 forKey:@"pop1_go"];
            }
        }];
        [_byType.layer pop_addAnimation:pop0 forKey:@"pop0_go"];
    }
}

@end
