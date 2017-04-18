//
//  HomeViewController.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/12.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "Define.h"
#import "SubjectViewController.h"
#import "SelectChapterVC.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHomeView];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configHomeView {
    _homeView = [[HomeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-113)];
    [self.view addSubview:_homeView];
    _homeView.homeTabview.delegate = self;
    _homeView.homeTabview.dataSource = self;
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [[HomeTableViewCell alloc] init];
    switch (indexPath.section) {
        case 0:
            cell.courseName.text = @"马克思主义基本原理概论";
            cell.practice.backgroundColor = [UIColor colorWithRed:62.f/255 green:88.f/255 blue:71.f/255 alpha:1];
            cell.byType.backgroundColor = [UIColor colorWithRed:62.f/255 green:88.f/255 blue:71.f/255 alpha:1];
            cell.byChapter.backgroundColor = [UIColor colorWithRed:62.f/255 green:88.f/255 blue:71.f/255 alpha:1];
            [cell.courseImage setImage:[UIImage imageNamed:@"mks"]];
            //[cell.practice addTarget:self action:@selector(OpenMKSPractice:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            cell.courseName.text = @"思想道德修养与法律基础";
            cell.practice.backgroundColor = [UIColor colorWithRed:160.f/255 green:105.f/255 blue:70.f/255 alpha:1];
            cell.byType.backgroundColor = [UIColor colorWithRed:160.f/255 green:105.f/255 blue:70.f/255 alpha:1];
            cell.byChapter.backgroundColor = [UIColor colorWithRed:160.f/255 green:105.f/255 blue:70.f/255 alpha:1];
            [cell.courseImage setImage:[UIImage imageNamed:@"sx"]];
            break;
        case 2:
            cell.courseName.text = @"毛泽东思想和中国特色\n社会主义理论体系概论";
            cell.practice.backgroundColor = [UIColor colorWithRed:105.f/255 green:7.f/255 blue:61.f/255 alpha:1];
            cell.byType.backgroundColor = [UIColor colorWithRed:105.f/255 green:7.f/255 blue:61.f/255 alpha:1];
            cell.byChapter.backgroundColor = [UIColor colorWithRed:105.f/255 green:7.f/255 blue:61.f/255 alpha:1];
            [cell.courseImage setImage:[UIImage imageNamed:@"mzt"]];
            break;
        case 3:
            cell.courseName.text = @"中国近代史纲要";
            cell.practice.backgroundColor = [UIColor colorWithRed:64.f/255 green:81.f/255 blue:158.f/255 alpha:1];
            cell.byType.backgroundColor = [UIColor colorWithRed:64.f/255 green:81.f/255 blue:158.f/255 alpha:1];
            cell.byChapter.backgroundColor = [UIColor colorWithRed:64.f/255 green:81.f/255 blue:158.f/255 alpha:1];
            [cell.byChapter addTarget:self action:@selector(gotoSelectChapter:) forControlEvents:UIControlEventTouchUpInside];
            [cell.courseImage setImage:[UIImage imageNamed:@"jds"]];
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.frame.size.width;
    if (indexPath.section == 2) {
        return (width-20)*2/3 +120;
    }
    return (width-20)*2/3 + 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SelectChapterVC *vc = [SelectChapterVC selectWithCourse:0];
        vc.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else if (indexPath.section == 1) {
        SelectChapterVC *vc = [SelectChapterVC selectWithCourse:1];
        vc.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else if (indexPath.section == 2) {
        SelectChapterVC *vc = [SelectChapterVC selectWithCourse:2];
        vc.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        SelectChapterVC *vc = [SelectChapterVC selectWithCourse:3];
        vc.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

#pragma mark - 响应事件
- (void)OpenMKSPractice:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    SubjectViewController *subjectVC = [[SubjectViewController alloc] initWithCourse:0];
    [self.navigationController pushViewController:subjectVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)gotoSelectChapter:(id)sender {
    SelectChapterVC *vc = [SelectChapterVC selectWithCourse:3];
    vc.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}





@end
