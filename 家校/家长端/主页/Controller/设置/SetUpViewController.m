//
//  SetUpViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/18.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "SetUpViewController.h"
#import "SetUpModel.h"
#import "SetUpTableViewCell.h"
#import "SelfCenterViewController.h"
#import "UpdatePassWordViewController.h"
#import "ParentInviteViewController.h"
#import "StatusSelectViewController.h"
#import "ParentStatusSelectViewController.h"
#import "DeanMailViewController.h"
#import "ConnectWithUsViewController.h"
@interface SetUpViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataListArr;
    
}
@end

@implementation SetUpViewController

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue:180 /255.0 alpha:1];
        self.title = @"设置";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}

- (void)loadData{
    
    NSArray *arrName1 = @[@"个人信息",@"修改密码",@"家长邀请",@"园长信箱"];
    NSArray *arrName2 = @[@"清空缓存",@"检查更新",@"关于我们"];
    NSArray *arrName3 = @[@"切换身份",@"退出登录"];
    NSArray *imageName1 = @[@"set_personalinfo",@"set_modifysecret",@"set_invite",@"set_email"];
    NSArray *imageName2 = @[@"set_clearcache",@"set_checkupdate",@"set_aboutus"];
    NSArray *imageName3 = @[@"set_toggle",@"set_loginout"];
    
    NSArray *infoArrName = @[arrName1,arrName2,arrName3];
    NSArray *infoArrImage = @[imageName1,imageName2,imageName3];
    for (int i = 0; i < 3; i++) {
        NSArray *arrName = infoArrName[i];
        NSArray *arrImage = infoArrImage[i];
        NSMutableArray *mtArr = [[NSMutableArray alloc]init];
        for (int k = 0; k < arrName.count; k++) {
            SetUpModel *model = [[SetUpModel alloc]init];
            model.logoImage = [UIImage imageNamed:arrImage[k]];
            model.titleLabel = arrName[k];
            model.selectLabel = @"";
            if (i == 2 && k == 0) {
                model.selectLabel = @"家长";
            }
            [mtArr addObject:model];
        }
        [_dataListArr addObject:mtArr];
    }
  
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}

#pragma mark ----返回按钮
- (void)doBack:(UIButton *)sender{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataListArr = [[NSMutableArray alloc]init];
    
    [self loadData];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight ) ];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if(ScaleHeight > 1){
        _tableView.scrollEnabled = NO;
    }
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ----TableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 2;
    }else if(section == 1){
        return 3;
    }else if(section == 3){
        return 0;
    }else{
        return 4;
    }
    return 0;
}
#pragma mark ----TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSIndexPath *indexPath = [[NSIndexPath alloc]initWithIndex:section];
    if (0 == indexPath.section) {//第一组
        return -20;
    }
    
    return 20;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    return view;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"setUp_cell";
    SetUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SetUpTableViewCell" owner:self options:nil] lastObject];
    }
    NSMutableArray *arr = _dataListArr[indexPath.section];
    cell.model = arr[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}


#pragma mark ----tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
    
        if (indexPath.row == 0) {
            SelfCenterViewController *scVC = [[SelfCenterViewController alloc]init];
            [self.navigationController pushViewController:scVC animated:YES];
         
        }
      
        if (indexPath.row == 1) {
            UpdatePassWordViewController *scVC = [[UpdatePassWordViewController alloc]init];
            [self.navigationController pushViewController:scVC animated:YES];
        }
        if (indexPath.row == 2) {
            ParentInviteViewController *pVC = [[ParentInviteViewController alloc]init];
            [self.navigationController pushViewController:pVC animated:YES];
        }
        if (indexPath.row == 3) {
            DeanMailViewController *dmVC = [[DeanMailViewController alloc]init];
            [self.navigationController pushViewController:dmVC animated:YES];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            ConnectWithUsViewController *swuVC = [[ConnectWithUsViewController alloc]init];
            [self.navigationController pushViewController:swuVC animated:YES];
        }
    }
    
    if(indexPath.section == 2){
        if (indexPath.row == 0) {
            ParentStatusSelectViewController *statusSelctVC = [[ParentStatusSelectViewController alloc]initWithNibName:@"ParentStatusSelectViewController" bundle:nil];
            [self.navigationController pushViewController:statusSelctVC animated:YES];
            [statusSelctVC setBlock:^(NSInteger index) {
                
                _block(index);
            }];
        }
        
        if (indexPath.row == 1) {
            self.navigationController.navigationBarHidden = NO;
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -2)] animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                _block(3);//教师端
            });

            
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
