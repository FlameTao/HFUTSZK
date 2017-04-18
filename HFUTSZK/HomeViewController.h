//
//  HomeViewController.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/12.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeView.h"

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) HomeView *homeView;
- (void)configHomeView;

@end
