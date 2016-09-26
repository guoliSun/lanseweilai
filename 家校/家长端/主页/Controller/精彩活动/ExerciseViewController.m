//
//  ExerciseViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/19.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "ExerciseViewController.h"
#import "ExerciseInfoViewController.h"
#import "BaseInfoTableViewCell.h"
#import "SDRefresh.h"
@interface ExerciseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSDictionary *_dataDic;//数据字典
    NSMutableArray *_infoArr;//数据数组

}

@property (nonatomic,weak)SDRefreshHeaderView *refreshHeader;
@property (nonatomic,weak)SDRefreshFooterView *refreshFooter;
@end

@implementation ExerciseViewController

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
        
        self.title = @"精彩活动";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        
    }
    return self;
}

#pragma mark ----返回按钮
- (void)doBack:(UIButton *)sender{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _infoArr = [[NSMutableArray alloc]init];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 49)];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    _tableView.separatorStyle = NO;
    
    [self setupSDRefresh];
}

- (void)dataListWithDic:(NSDictionary *)dic{
    NSArray *infoArr = [dic objectForKey:@"results"];
    _infoArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < infoArr.count; i++) {
        NotifyModel *model = [[NotifyModel alloc]init];
        model.timeString = [infoArr[i] objectForKey:@"createDate"];
        model.imageName = [infoArr[i] objectForKey:@"headIcon.png"];
        model.titleName = [infoArr[i] objectForKey:@"title"];
        [_infoArr addObject:model];
    }
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
    NSString *url = [NSString stringWithFormat:ExerciseURL,@"6",@"1"];
    _infoArr = [[NSMutableArray alloc]init];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AFNetManager postRequestWithURL:url withParameters:nil success:^(id response) {
            _dataDic = response;
            [self dataListWithDic:_dataDic];
            [_tableView reloadData];
            [_refreshHeader endRefreshing];
        }];
    });
}

- (void)footerRefresh{
    
    NSString *url = [NSString stringWithFormat:ExerciseURL,@"6",@"1"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AFNetManager postRequestWithURL:url withParameters:nil success:^(id response) {
            _dataDic = response;
            [self dataListWithDic:_dataDic];
            [_tableView reloadData];
            [_refreshHeader endRefreshing];
        }];
    });

}



- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;

}

#pragma mark ----TableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_infoArr) {
        NSArray *infoArr = [_dataDic objectForKey:@"results"];
        return infoArr.count;
    }
    return 0;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"base_cell";
    BaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BaseInfoTableViewCell" owner:self options:nil]lastObject];
    }
    cell.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    NotifyModel *model = _infoArr[indexPath.row];
    cell.model = model;
    return cell;
    
}

#pragma mark ----tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 270 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *infoArr = [_dataDic objectForKey:@"results"];
    ExerciseInfoViewController *einfoVC = [[ExerciseInfoViewController alloc]initWirhDic:infoArr[indexPath.row]];
    [self.navigationController pushViewController:einfoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
