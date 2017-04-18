//
//  PersonalViewController.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/12.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalTableViewCell.h"
#import "Define.h"
#import "ChatMeViewController.h"
#import "AboutViewController.h"
#import "SelectCourseVC.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _personalView = [[PersonalView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-113)];
    
    _personalView.personalTableView.delegate = self;
    _personalView.personalTableView.dataSource = self;

    [self.view addSubview:_personalView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *personalCellID = @"personalCellID";
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:personalCellID];
    if (cell == nil) {
        cell = [[PersonalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personalCellID];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.cellTitle.text = @"我的错题";
            cell.cellMark.image = [UIImage imageNamed:@"errors"];
        } else if (indexPath.row == 1) {
            cell.cellTitle.text = @"我的收集";
            cell.cellMark.image = [UIImage imageNamed:@"collection"];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.cellTitle.text = @"联系我们";
            cell.cellMark.image = [UIImage imageNamed:@"chatme"];
        } else if (indexPath.row == 1) {
            cell.cellTitle.text = @"关于";
            cell.cellMark.image = [UIImage imageNamed:@"about"];
        }
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SelectCourseVC *vc = [SelectCourseVC selectWrongCourse];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } else if (indexPath.row == 1) {
            SelectCourseVC *vc = [SelectCourseVC selectCollectionCourse];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ChatMeViewController *chatmeVC = [[ChatMeViewController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chatmeVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } else if (indexPath.row == 1) {
            AboutViewController *aboutVC = [[AboutViewController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
