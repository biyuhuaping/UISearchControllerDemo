//
//  BaseTabBarController.m
//  UISearchControllerDemo
//
//  Created by ZB on 2020/6/22.
//  Copyright © 2020 zhoubo. All rights reserved.
//

#import "BaseTabBarController.h"
#import "ViewController.h"
#import "SearchDetailVC.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化viewControllers
    [self initTabbarItems];
    self.delegate = self;
    [UITabBar appearance].translucent = NO;// 去除iOS12.1磨砂透明度，解决tabbar像素偏移bug
}

- (void)initTabbarItems {
    NSArray *imageArray = @[@"首页非当前页icon",@"我的非当前页icon"];
    NSArray *selectedImageArray = @[@"首页当前页icon", @"我的当前页icon"];

//    NSArray *imageArray = @[@"首页非当前页icon",@"投资非当前页icon", @"财富非当前页icon", @"我的非当前页icon"];
//    NSArray *selectedImageArray = @[@"首页当前页icon", @"投资当前页icon", @"财富当前页icon", @"我的当前页icon"];
    
    ViewController *home = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self addChildViewController:home navTitle:nil tabbarTitle:@"首页" imageNamed:imageArray[0] selectedImageName:selectedImageArray[0]];
    
    SearchDetailVC *min = [[SearchDetailVC alloc]initWithNibName:@"SearchDetailVC" bundle:nil];
    [self addChildViewController:min navTitle:nil tabbarTitle:@"内容" imageNamed:imageArray[1] selectedImageName:selectedImageArray[1]];
    
    
    //统一设置（选中/未选中）文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor] } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor] } forState:UIControlStateSelected];
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc navTitle:(NSString *)navTitle tabbarTitle:(NSString *)tabbarTitle imageNamed:(NSString *)imageNamed selectedImageName:(NSString*)selectedImageName {
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
    vc.navigationItem.title = navTitle;
    nav.tabBarItem.title = tabbarTitle;
    
    nav.tabBarItem.image = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 单独设置选中tabbar文字颜色
    //    [vc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] } forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
}

#pragma mark - UITabBarControllerDelegate
/**
 *  点击Item时调用：控制哪些 ViewController 的标签栏能被点击
 *  @return YES:允许点击 NO:不允许点击
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

/**
 *  点击Item时调用
 *  @param viewController   将要点击的目标控制器
 */
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"%lu",(unsigned long)self.selectedIndex);
}

@end
