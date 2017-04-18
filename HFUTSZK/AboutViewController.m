
//
//  AboutViewController.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "AboutViewController.h"
#import "ExplanationViewController.h"
#import "HelpViewController.h"
#import "AboutUsViewController.h"
#import "Define.h"
#import "Masonry.h"

@interface AboutViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于";
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ret"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(ret:)];
    self.navigationItem.leftBarButtonItem = itemleft;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UISwipeGestureRecognizer *rightForRet = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ret:)];
    rightForRet.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightForRet];
    
    _aboutView = [[AboutView alloc] initWithFrame:self.view.frame];
    _aboutView.aboutTableView.delegate = self;
    _aboutView.aboutTableView.dataSource = self;
    [self.view addSubview:_aboutView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ret:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 3;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *aboutID = @"aboutID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aboutID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutID];
    }
    if (indexPath.section == 0) {
        cell.userInteractionEnabled = NO;
        UILabel *appName = [[UILabel alloc] init];
        appName.text = @"工大思政";
        appName.font = [UIFont boldSystemFontOfSize:30];
        appName.textColor = FMColorWithHex(0x59d6e1);
        appName.translatesAutoresizingMaskIntoConstraints = NO;
        [cell addSubview:appName];
        [appName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.mas_centerX);
            make.top.equalTo(cell.mas_top).offset(20);
        }];
        UILabel *version = [[UILabel alloc] init];
        version.text = @"V1.0.0";
        version.font = [UIFont systemFontOfSize:16];
        version.textColor = [UIColor grayColor];
        version.translatesAutoresizingMaskIntoConstraints = NO;
        [cell addSubview:version];
        [version mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.mas_centerX);
            make.bottom.equalTo(cell.mas_bottom).offset(-10);
        }];
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"说明";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"使用帮助";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"关于我们";
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //说明
            ExplanationViewController *vc = [[ExplanationViewController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        } else if (indexPath.row == 1) {
            //使用帮助
            HelpViewController *vc = [[HelpViewController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {
            //关于我们
            AboutUsViewController *vc = [[AboutUsViewController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    } else {
        return 44;
    }
}





//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
//    view.backgroundColor= [UIColor whiteColor];
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    view.backgroundColor= [UIColor whiteColor];
//}

//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
//    [headerView setBackgroundColor:[UIColor whiteColor]];
//    return headerView;
//}
//
//- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
//    [headerView setBackgroundColor:[UIColor whiteColor]];
//    return headerView;
//}

//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    view.tintColor = [UIColor whiteColor];
//}
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
//    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
//        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
//        UIView* content = castView.contentView;
//        UIColor* color = [UIColor whiteColor]; // substitute your color here
//        content.backgroundColor = color;
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
