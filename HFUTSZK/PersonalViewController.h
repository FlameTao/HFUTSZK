//
//  PersonalViewController.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/12.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalView.h"
#import "PersonalModel.h"

@interface PersonalViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) PersonalView *personalView;
@property (nonatomic, strong) PersonalModal *personalModel;

@end
