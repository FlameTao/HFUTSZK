//
//  ViewController.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/12.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSLog(@"%@", path);
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:dbPath];
    if (!isExist) {
        NSString *bgDbPath = [[NSBundle mainBundle] pathForResource:@"szk_2016061902" ofType:@"db"];
        [fileManager copyItemAtPath:bgDbPath toPath:dbPath error:nil];
    }
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (db != nil) {
        NSLog(@"Success");
    }
    BOOL isOpen = [db open];
    if (isOpen) {
        NSLog(@"打开数据库成功");
        NSString *sql = @"select * from marxism;";
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            NSString *subject = [result stringForColumn:@"subject"];
            NSLog(@"%@", subject);
        }
    }
    
//    
//    NSString *sql = @"create table if not exists stu();";
//    [db executeUpdate:sql];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
