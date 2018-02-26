//
//  SearchViewController.m
//  UISearchControllerDeme
//
//  Created by 周博 on 2017/12/13.
//  Copyright © 2017年 zhoubo. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomTableViewCell.h"
#import "SearchDetailVC.h"
#import "AppDelegate.h"

@interface SearchViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *searchList;//满足搜索条件的数组
@property (strong, nonatomic) NSMutableArray *dataListArry;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.searchList = [NSMutableArray new];
    self.dataListArry = [NSMutableArray new];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;//不加的话，table会下移
    self.edgesForExtendedLayout = UIRectEdgeNone;//不加的话，UISearchBar返回后会上移
    
    //产生100个数字+三个随机字母
    for (NSInteger i = 0; i<100; i++) {
        [self.dataListArry addObject:[NSString stringWithFormat:@"%ld%@",(long)i,[self shuffledAlphabet]]];
    }
}

- (void)viewWillLayoutSubviews{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate tabbarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.searchList.count > 0 ? 44 : 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger i = self.searchList.count > 0 ? self.searchList.count : 1;
    return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchList.count > 0) {
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = self.searchList[indexPath.row];
        cell.textLabel.textColor = [UIColor redColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return cell;
    }else{
        CustomTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil][0];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchDetailVC *vc = [[SearchDetailVC alloc]initWithNibName:@"SearchDetailVC" bundle:nil];
    [self.nav pushViewController:vc animated:YES];
}

#pragma mark - UISearchResultsUpdating
//每输入一个字符都会执行一次
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSLog(@"搜索关键字：%@",searchController.searchBar.text);
    searchController.searchResultsController.view.hidden = NO;

    //谓词搜索
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchController.searchBar.text];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    
    //过滤数据
    self.searchList = [NSMutableArray arrayWithArray:[_dataListArry filteredArrayUsingPredicate:preicate]];
    //刷新表格
    
    [self.tableView reloadData];
}

@end
