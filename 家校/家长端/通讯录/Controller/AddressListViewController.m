//
//  AddressListViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/16.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressListInfoViewController.h"
#import "AddressListTableViewCell.h"
@interface AddressListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>
{
        UITableView *_tableView;
        UIImageView *_selectImageView;
        UILabel *_selectLabel;
        UITextField *_selectTextField;
}
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *displayController;
@end

@implementation AddressListViewController

- (instancetype)init{
    
    if (self = [super init]) {
        
        //设置控制器的 题目(导航栏) 标签图片(标签栏)
        self.title = @"通讯录";
        self.tabBarItem.image = [UIImage imageNamed:@"contact"];
        self.tabBarItem.title = @"通讯录";
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight )];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _tableView.tableHeaderView = view;
    _tableView.tableFooterView = [[UIView alloc]init];
    //_tableView.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self createSelectTextFile];
    
    
}

#pragma mark ----顶部搜索框
- (void)createSelectTextFile{
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    self.searchBar.barStyle     = UIBarStyleDefault;
    self.searchBar.translucent  = YES;
    self.searchBar.delegate     = self;
    
    self.searchBar.placeholder  = @"搜索";
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTitle:@"取消"];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    
    [_tableView addSubview:self.searchBar];
    
    
    self.displayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.displayController.delegate                = self;
    self.displayController.searchResultsDataSource = self;
    self.displayController.searchResultsDelegate   = self;
    self.displayController.searchContentsController.edgesForExtendedLayout = UIRectEdgeNone;
}
#pragma mark ----tableViewDatasouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"addressList_cell";
    AddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AddressListTableViewCell" owner:self options:nil]lastObject];
    }
    if (indexPath.row == 0) {
        cell.nameLabel.text= @"王小二";
        cell.postLabel.text = @"(班主任)";
    }
    if (indexPath.row == 1) {
        cell.nameLabel.text= @"张三";
        cell.postLabel.text = @"(生物老师)";
    }
    if (indexPath.row == 2) {
        cell.nameLabel.text= @"张大拿";
        cell.postLabel.text = @"(化学老师)";
    }
     cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

#pragma mark ----tableviewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    AddressListInfoViewController *vc = [[AddressListInfoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----tableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.searchBar.top = _tableView.contentOffset.y;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end