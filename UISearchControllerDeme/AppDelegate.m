//
//  AppDelegate.m
//  UISearchControllerDeme
//
//  Created by 周博 on 2017/12/13.
//  Copyright © 2017年 zhoubo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()
@property (strong, nonatomic) UITabBarController *tabbarCtr;
@end

@implementation AppDelegate
- (void)tabbarHidden:(BOOL)hidden{
    CGFloat tabbarHight = hidden?-83:0;
    CGRect rectWindow = self.window.frame;
    CGRect rectTabBar = self.tabbarCtr.tabBar.frame;
    rectTabBar.size.height = tabbarHight;
    rectTabBar.origin.y = CGRectGetHeight(rectWindow) - tabbarHight;
    self.tabbarCtr.tabBar.frame = rectTabBar;
    self.tabbarCtr.selectedViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth(rectWindow), CGRectGetMaxY(rectTabBar));
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    self.tabbarCtr = [[UITabBarController alloc]init];
    [self.tabbarCtr addChildViewController:nav];
    self.window.rootViewController = self.tabbarCtr;
    [self.window makeKeyAndVisible];
    
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


@end
