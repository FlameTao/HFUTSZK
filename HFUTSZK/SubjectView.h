//
//  SubjectView.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Option.h"
#import "SubjectModel.h"

@interface SubjectView : UIScrollView

//@property (nonatomic, strong) UITableView *subjectTableView;    // tableview of subject

@property (nonatomic, strong) UILabel *subjectType;             // type of subject
@property (nonatomic, strong) UILabel *subjectContent;          // content of subject

@property (nonatomic, strong) Option *opA;
@property (nonatomic, strong) Option *opB;
@property (nonatomic, strong) Option *opC;
@property (nonatomic, strong) Option *opD;

@property (nonatomic, strong) UIButton *commit;
@property (nonatomic, strong) NSString *moreselectAnswer;

- (void)showSubject:(SubjectModel*)subject;

- (CGFloat)height:(SubjectModel*)subject;

- (void)successMarkWithSelectedOpsition:(NSInteger)selectedOpsition subjectType:(NSInteger)subjectType;
- (void)failureMarkWithSelectedOpsition:(NSInteger)selectedOpstion subjectModel:(SubjectModel*)model;

- (void)moreSelectSuccess;
- (void)moreSelectFailureWithSubjectModel:(SubjectModel*)model;


- (void)closeOpUse;
- (void)openOpUse;

@property (nonatomic) BOOL dragEnable;
@property (nonatomic) CGPoint beginPoint;

@end
