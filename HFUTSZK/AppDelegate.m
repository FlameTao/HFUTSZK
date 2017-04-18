//
//  AppDelegate.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/12.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "PersonalViewController.h"
#import "TestHomeViewController.h"
#import "Define.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //[NSThread sleepForTimeInterval:1.0f];
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSLog(@"%@", path);
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:dbPath];
    if (!isExist) {
        NSString *bgDbPath = [[NSBundle mainBundle] pathForResource:@"szk_2016061902" ofType:@"db"];
        [fileManager copyItemAtPath:bgDbPath toPath:dbPath error:nil];
    }
    
    // 存储一些元素
    [self firstLaunch];
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    HomeViewController *vc0 = [[HomeViewController alloc] init];
    vc0.title = @"思政课";
    UITabBarItem *item0 = [[UITabBarItem alloc] initWithTitle:@"思政课" image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageNamed:@"home"]];
    vc0.tabBarItem = item0;

    PersonalViewController *vc1 = [[PersonalViewController alloc] init];
    vc1.title = @"我";
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"person"] selectedImage:[UIImage imageNamed:@"person"]];
    vc1.tabBarItem = item;
    
    TestHomeViewController *vc2 = [[TestHomeViewController alloc] init];
    vc2.title = @"模拟";
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"模拟" image:[UIImage imageNamed:@"test"] selectedImage:[UIImage imageNamed:@"test"]];
    vc2.tabBarItem = item2;
    
    UINavigationController *nav0 = [[UINavigationController alloc] initWithRootViewController:vc0];
    nav0.navigationBar.barTintColor = FMColorWithHex(0x59d6e1);
    nav0.navigationBar.translucent = NO;
    [nav0.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    nav0.navigationBar.barStyle = UIBarStyleBlack;
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    nav1.navigationBar.barTintColor = FMColorWithHex(0x59d6e1);
    nav1.navigationBar.translucent = NO;
    [nav1.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    nav1.navigationBar.barStyle = UIBarStyleBlack;
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nav2.navigationBar.barTintColor = FMColorWithHex(0x59d6e1);
    nav2.navigationBar.translucent = NO;
    [nav2.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    nav2.navigationBar.barStyle = UIBarStyleBlack;
    
    NSArray *array = [NSArray arrayWithObjects:nav0, nav2, nav1, nil];
    UITabBarController *tb = [[UITabBarController alloc] init];
    tb.viewControllers = array;
    tb.tabBar.tintColor = FMColorWithHex(0x59d6e1);
    tb.tabBar.translucent = NO;
    
    _window.rootViewController = tb;
    [_window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)firstLaunch {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if(![user boolForKey:@"firstLaunch"]){
        [user setBool:YES forKey:@"firstLaunch"];
        
        [user setInteger:1 forKey:@"my0"];
        [user setInteger:1 forKey:@"my1"];
        [user setInteger:1 forKey:@"my2"];
        [user setInteger:1 forKey:@"my3"];
        [user setInteger:1 forKey:@"my4"];
        [user setInteger:1 forKey:@"my5"];
        [user setInteger:1 forKey:@"my6"];
        [user setInteger:1 forKey:@"my7"];
        [user setInteger:1 forKey:@"my"];
        [user setInteger:1 forKey:@"sx0"];
        [user setInteger:1 forKey:@"sx1"];
        [user setInteger:1 forKey:@"sx2"];
        [user setInteger:1 forKey:@"sx3"];
        [user setInteger:1 forKey:@"sx4"];
        [user setInteger:1 forKey:@"sx5"];
        [user setInteger:1 forKey:@"sx6"];
        [user setInteger:1 forKey:@"sx7"];
        [user setInteger:1 forKey:@"sx"];
        [user setInteger:1 forKey:@"mzt1"];
        [user setInteger:1 forKey:@"mzt2"];
        [user setInteger:1 forKey:@"mzt3"];
        [user setInteger:1 forKey:@"mzt4"];
        [user setInteger:1 forKey:@"mzt5"];
        [user setInteger:1 forKey:@"mzt6"];
        [user setInteger:1 forKey:@"mzt7"];
        [user setInteger:1 forKey:@"mzt8"];
        [user setInteger:1 forKey:@"mzt9"];
        [user setInteger:1 forKey:@"mzt10"];
        [user setInteger:1 forKey:@"mzt11"];
        [user setInteger:1 forKey:@"mzt12"];
        [user setInteger:1 forKey:@"mzt"];
        [user setInteger:1 forKey:@"jds1"];
        [user setInteger:1 forKey:@"jds2"];
        [user setInteger:1 forKey:@"jds3"];
        [user setInteger:1 forKey:@"jds4"];
        [user setInteger:1 forKey:@"jds5"];
        [user setInteger:1 forKey:@"jds6"];
        [user setInteger:1 forKey:@"jds7"];
        [user setInteger:1 forKey:@"jds"];
        [user setInteger:1 forKey:@"wrong0"];
        [user setInteger:1 forKey:@"wrong1"];
        [user setInteger:1 forKey:@"wrong2"];
        [user setInteger:1 forKey:@"wrong3"];
        [user setInteger:1 forKey:@"collection0"];
        [user setInteger:1 forKey:@"collection1"];
        [user setInteger:1 forKey:@"collection2"];
        [user setInteger:1 forKey:@"collection3"];
    }else{
        //不是第一次启动了
    }
}


@end
