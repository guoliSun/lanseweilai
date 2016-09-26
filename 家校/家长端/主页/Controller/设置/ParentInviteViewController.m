//
//  ParentInviteViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/23.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "ParentInviteViewController.h"
#import "ParentInviteTopView.h"
#import "ParentInviteGroupView.h"
#import "ParentInviteViewAddViewController.h"
#import "ParentInviteTableViewCell.h"
@interface ParentInviteViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    UITableView *_tableView;
    NSArray *_infoArr;
}

@end

@implementation ParentInviteViewController

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        
        self.title = @"家人邀请";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [self AFNetManager];
}

- (void)doBack:(UIButton *)sender{
    [self.navigationController  popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self AFNetManager];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
   
    //_tableView.tableFooterView = [[UIView alloc]init];
    ParentInviteTopView *view = [[[NSBundle mainBundle]loadNibNamed:@"ParentInviteTopView" owner:self options:nil] lastObject];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    tap.delegate = self;
    [view addGestureRecognizer:tap];
    
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 66)];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    view.top = 64;
    [self.view addSubview:view];
}

- (void)AFNetManager{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [accountDefaults objectForKey:@"userInfo"];
    NSString *url = [NSString stringWithFormat:InviteListUrl,[userInfo objectForKey:@"userId"]];
    [AFNetManager postRequestWithURL:url withParameters:nil success:^(id response) {
        _infoArr = [response objectForKey:@"results"];
        [_tableView reloadData];
    }];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (tap.numberOfTapsRequired == 1) {
        
        ParentInviteViewAddViewController *addVC = [[ParentInviteViewAddViewController alloc]init];
        [self.navigationController pushViewController:addVC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_infoArr.count == 0) {
        return 0;
    }
    return _infoArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_infoArr.count == 0) {
        return 0;
    }
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ParentInviteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"parentInvite_cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ParentInviteTableViewCell" owner:self options:nil]lastObject];
    }
    NSDictionary *infoDic = _infoArr[indexPath.section];
    cell.nameLabel.text = [infoDic objectForKey:@"relativeName"];
    cell.relationLabel.text = [infoDic objectForKey:@"relationShip"];
    cell.phoneLabel.text = [infoDic objectForKey:@"phone"];
    NSArray *childArr = [infoDic objectForKey:@"child"];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i< childArr.count; i++) {
        NSString *name = [childArr[i] objectForKey:@"studentName"];
        [arr addObject:name];
    }
    NSString *connectS = [arr componentsJoinedByString:@"、"];
    cell.connectLabel.text = connectS;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return  50;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ParentInviteGroupView *view = [[[NSBundle mainBundle]loadNibNamed:@"ParentInviteGroupView" owner:self options:nil] lastObject];
    view.titleView.text = [NSString stringWithFormat:@"邀请%ld",section + 1];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 225;
}

@end
