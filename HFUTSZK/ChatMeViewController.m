//
//  ChatMeViewController.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "ChatMeViewController.h"
#import "HFUTNotificationCenter.h"

@interface ChatMeViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ChatMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"联系我们";
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ret"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(ret:)];
    self.navigationItem.leftBarButtonItem = itemleft;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _chatmeView = [[ChatMeView alloc] initWithFrame:self.view.frame];
    
    _chatmeView.chatMeTableView.delegate = self;
    _chatmeView.chatMeTableView.dataSource = self;
    
    [self.view addSubview:_chatmeView];
    
    UISwipeGestureRecognizer *rightForRet = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ret:)];
    rightForRet.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightForRet];
    
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ret"] style:UIBarButtonItemStylePlain target:self action:@selector(popTo:)];
//    self.navigationItem.leftBarButtonItem = left;
    
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
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *chatmeID = @"chatmeID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chatmeID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chatmeID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"flametao@126.com";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"420594855";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Email";
    } else if (section == 1) {
        return @"QQ";
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    // 可以支持所有Action，也可以只支持其中一种或者两种Action
    if (action == @selector(copy:)) { // 支持复制
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if (action == @selector(copy:)) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard]; // 黏贴板
        [pasteBoard setString:cell.textLabel.text];
        HFUTNotificationCenter *notification = [HFUTNotificationCenter notificationWithTitle:@"复制成功" Type:HFUTNotificationSuccess];
        [notification show];
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

//- (void)popTo:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
