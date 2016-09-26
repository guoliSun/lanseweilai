//
//  NotifyViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/16.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "NotifyViewController.h"
#import "SignUpViewController.h"
#import "NPayViewController.h"
#import "SchoolNotifyInfoViewController.h"
#import "BaseInfoTableViewCell.h"
#import "SDRefresh.h"
@interface NotifyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableDictionary *_dataDic;//数据字典
    NSMutableArray *_infoArr;//数据数组
}

@property (nonatomic,weak)SDRefreshHeaderView *refreshHeader;
@property (nonatomic,weak)SDRefreshFooterView *refreshFooter;
@end

@implementation NotifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    self.title = @"通知公告";
    _infoArr = [[NSMutableArray alloc]init];
    backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    //重新定义返回按钮
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //创建tableView
   
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self setupSDRefresh];
    
}
- (void)dataListWithDic:(NSDictionary *)dic{
    NSArray *infoArr = [dic objectForKey:@"results"];
    for (int i = 0; i < infoArr.count; i++) {
        NotifyModel *model = [[NotifyModel alloc]init];
        model.timeString = [infoArr[i] objectForKey:@"createDate"];
        model.imageName = [infoArr[i] objectForKey:@"headIcon.png"];
        model.titleName = [infoArr[i] objectForKey:@"title"];
        [_infoArr addObject:model];
    }
}
#pragma mark ----返回按钮
- (void)doBack:(UIButton *)sender{
     self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupSDRefresh{
    
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    [refreshHeader addToScrollView:_tableView];
    
    [refreshHeader addTarget:self refreshAction:@selector(headerRefresh)];
    
    _refreshHeader = refreshHeader;
    
    [refreshHeader autoRefreshWhenViewDidAppear];
    
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    
    [refreshFooter addToScrollView:_tableView];
    
    _refreshFooter = refreshFooter;
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    
    _refreshFooter = refreshFooter;
    
    
}

- (void)headerRefresh{
    NSString *notifyURL = [NSString stringWithFormat:NotifyURL,@"6",@"1"];
    _infoArr = [[NSMutableArray alloc]init];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AFNetManager postRequestWithURL:notifyURL withParameters:nil success:^(id response) {
            _dataDic = response;
            [self dataListWithDic:_dataDic];
            [_tableView reloadData];
            [_refreshHeader endRefreshing];
        }];
    });
}

- (void)footerRefresh{
    
    NSString *notifyURL = [NSString stringWithFormat:NotifyURL,@"6",@"1"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AFNetManager postRequestWithURL:notifyURL withParameters:nil success:^(id response) {
            _dataDic = response;
            [self dataListWithDic:_dataDic];
            [_tableView reloadData];
            [_refreshFooter endRefreshing];
        }];
    });
}


#pragma mark ----TableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_infoArr.count) {
        return _infoArr.count;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"base_cell";
    
    BaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];  //删除并进行重新分配
    }
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BaseInfoTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
     cell.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1];
    NotifyModel *model = _infoArr[0];
    cell.model = model;
    return cell;
}

#pragma mark ----TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 270;
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#warning -----跳转需要进行判断
    if (_index == 1) {
        SchoolNotifyInfoViewController *sniVC = [[SchoolNotifyInfoViewController alloc]init];
        [self.navigationController pushViewController:sniVC animated:YES];
        return;
    }else{
        NSArray *infoArr = [_dataDic objectForKey:@"results"];
        if (indexPath.row == 0) {
            SignUpViewController *signUp = [[SignUpViewController alloc]initWithDic:infoArr[0]];
            [self.navigationController pushViewController:signUp animated:YES];
        }
        if (indexPath.row == 1) {
            NPayViewController *nvc = [[NPayViewController alloc]initWithDic:infoArr[0]];
            [self.navigationController pushViewController:nvc animated:YES];
        }
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
