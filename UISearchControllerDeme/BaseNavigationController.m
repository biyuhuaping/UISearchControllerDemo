//
//  BaseNavigationController.m
//  zhike
//
//  Created by 周博 on 2017/11/24.
//  Copyright © 2017年 zhoubo. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //点击返回按钮，将所有的文本框失焦
//    [[UIApplication sharedApplication] resignFirstResponder];
//    [self.navigationController popViewControllerAnimated:YES];
    [self setNavStyles];
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置导航条样式
- (void)setNavStyles{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置显示的颜色
//    bar.barTintColor = [UIColor colorWithRed:62/255.0 green:173/255.0 blue:176/255.0 alpha:1.0];
    bar.barTintColor = [UIColor colorWithRed:238/255.0 green:91/255.0 blue:73/255.0 alpha:1.0];
    
    //设置字体颜色
    bar.tintColor = [UIColor whiteColor];//左右两边字体颜色
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //替换原来的返回图片
//    bar.backIndicatorImage = [UIImage imageNamed:@"icon_back"];
//    bar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"icon_back"];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];

    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
