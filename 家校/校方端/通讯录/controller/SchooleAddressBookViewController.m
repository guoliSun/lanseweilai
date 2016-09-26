//
//  SchooleAddressBookViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/24.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "SchooleAddressBookViewController.h"
#import "SchoolAddressListInfoViewController.h"
#import "AddressListTableViewCell.h"
@interface SchooleAddressBookViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UITableView *_tableView;
    UIImageView *_selectImageView;
    UILabel *_selectLabel;
    UITextField *_selectTextField;
}
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *displayController;
@end

@implementation SchooleAddressBookViewController
- (instancetype)init{
    
    if (self = [super init]) {
        
        //设置控制器的 题目(导航栏) 标签图片(标签栏)
        self.title = @"通讯录";
        self.view.backgroundColor = [UIColor whiteColor];
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
        cell.postLabel.text = @"爸爸-李明";
    }
    if (indexPath.row == 1) {
        cell.nameLabel.text= @"张三";
        cell.postLabel.text = @"妈妈-小陈";
    }
    if (indexPath.row == 2) {
        cell.nameLabel.text= @"张大拿";
        cell.postLabel.text = @"爸爸-大张";
    }
    cell.postLabel.font = [UIFont systemFontOfSize:12];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

#pragma mark ----tableviewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SchoolAddressListInfoViewController *vc = [[SchoolAddressListInfoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.searchBar.top = _tableView.contentOffset.y;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end