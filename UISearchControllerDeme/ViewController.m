//
//  ViewController.m
//  UISearchControllerDeme
//
//  Created by 周博 on 2017/12/13.
//  Copyright © 2017年 zhoubo. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"
#import "SearchDetailVC.h"

@interface ViewController ()<UISearchControllerDelegate,UISearchBarDelegate>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) SearchViewController *searchVC;

//tableView
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataListArry;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索列表";
    
    self.dataListArry = [NSMutableArray arrayWithCapacity:100];
    
    //产生100个数字+三个随机字母
    for (NSInteger i =0; i<100; i++) {
        [self.dataListArry addObject:[NSString stringWithFormat:@"%ld%@",(long)i,[self shuffledAlphabet]]];
    }
    [self initSearchController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSearchController{
    self.searchVC = [[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
    
    //创建UISearchController
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self.searchVC];
    self.searchController.searchResultsUpdater = self.searchVC;
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    [self.searchController.searchBar sizeToFit];
    
    //包着搜索框外层的颜色
    self.searchController.searchBar.tintColor = [UIColor colorWithRed:22.0/255 green:161.0/255 blue:1.0/255 alpha:1];
//    self.searchController.searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
//    self.searchController.searchBar.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    
    self.searchController.searchBar.placeholder= @"搜索";
//    self.searchController.searchBar.text = @"默认搜索内容";
    
    //设置UISearchController的显示属性，以下3个属性默认为YES
    
    //搜索时，背景变暗色
    self.searchController.dimsBackgroundDuringPresentation = NO;
//    self.searchController.obscuresBackgroundDuringPresentation = NO;
    //点击搜索的时候,是否隐藏导航栏
//    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
//    iOS11之后searchController有了新样式，可以放在导航栏
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchController;
    } else {
        self.tableView.tableHeaderView = self.searchController.searchBar;
    }

#warning 如果进入预编辑状态,searchBar消失(UISearchController套到TabBarController可能会出现这个情况),请添加下边这句话
    self.definesPresentationContext = YES;
    self.searchVC.nav = self.navigationController;
    self.searchVC.searchBar = self.searchController.searchBar;
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

//产生3个随机字母
- (NSString *)shuffledAlphabet {
    NSMutableArray * shuffledAlphabet = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];
    
    NSString *strTest = [[NSString alloc]init];
    for (int i=0; i<3; i++) {
        int x = arc4random() % 25;
        strTest = [NSString stringWithFormat:@"%@%@",strTest,shuffledAlphabet[x]];
    }
    return strTest;
}

#pragma mark - tableView
//设置区域的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataListArry count];
}

//返回单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell.textLabel setText:self.dataListArry[indexPath.row]];
    return cell;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    for (id obj in [searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"取消" forState:UIControlStateNormal];
                }
            }
        }
    }
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    SearchDetailVC *vc = [[SearchDetailVC alloc]initWithNibName:@"SearchDetailVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
//    self.searchController.active = NO;
}

#pragma mark - UISearchControllerDelegate代理
//测试UISearchController的执行过程
- (void)willPresentSearchController:(UISearchController *)searchController {
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController {
    NSLog(@"presentSearchController");
}


@end
