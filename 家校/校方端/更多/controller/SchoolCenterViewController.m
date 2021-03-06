//
//  SchoolCenterViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/29.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "SchoolCenterViewController.h"
#import "SelfCenterTableViewCell.h"
#import "SelfCenterModel.h"
#import "ParentCutStudentViewController.h"
#import "UpdatePhoneViewController.h"
@interface SchoolCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_infoArr;
}


@end

@implementation SchoolCenterViewController

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"个人信息";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}

- (void)dataList{
    _infoArr = [[NSMutableArray alloc]init];
    NSArray *arrName = @[@"头像",@"姓名",@"园区",@"职务",@"性别",@"联系电话"];
    NSArray *arrInfo = @[@"touxiang",@"李明",@"XX幼儿园",@"班主任",@"男",@"13366668888"];
    for (int i = 0; i < arrName.count; i++) {
        SelfCenterModel *model = [[SelfCenterModel alloc]init];
        model.titleLabel = arrName[i];
        if (i == 0) {
            model.userimage = [UIImage imageNamed:arrInfo[i]];
        }else{
            model.rightLabel = arrInfo[i];
        }
        [_infoArr addObject:model];
    }
    
}
- (void)doBack:(UIButton *)sender{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dataList];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.scrollEnabled = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----TableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"selfCenter_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        [cell addSubview:[self createImageView]];
    }
    else if (indexPath.row == 5 ) {
        [cell addSubview:[self createCellRightWithModel:_infoArr[indexPath.row]]];
    }else{
        [cell addSubview:[self createCellWithModel:_infoArr[indexPath.row]]];
    }
    
    
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

- (UIView *)createImageView{
    SelfCenterModel *model =  _infoArr[0];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, 100, 20)];
    titleLabel.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    titleLabel.text = model.titleLabel;
    [view addSubview:titleLabel];
    
    UIImageView *userImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 110, 15, 70, 70)];
    userImage.image = model.userimage;
    [view addSubview:userImage];
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 35, 40, 20, 20)];
    rightImageView.image = [UIImage imageNamed:@"rightarrow"];
    [view addSubview:rightImageView];
    return view;
}

#pragma mark -----tableViewDelegat
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 5){
        UpdatePhoneViewController *upVC = [[UpdatePhoneViewController alloc]initWithNibName:@"UpdatePhoneViewController" bundle:nil];
        [self.navigationController pushViewController:upVC animated:YES];
    }
}

- (UIView *)createCellRightWithModel:(SelfCenterModel *)model{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
    titleLabel.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    titleLabel.text = model.titleLabel;
    [view addSubview:titleLabel];
    
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 45 - 150, 15, 150, 20)];
    rightLabel.text = model.rightLabel;
    [view addSubview:rightLabel];
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 35, 15, 20, 20)];
    rightImageView.image = [UIImage imageNamed:@"rightarrow"];
    [view addSubview:rightImageView];
    return view;
}

- (UIView *)createCellWithModel:(SelfCenterModel *)model{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
    titleLabel.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    titleLabel.text = model.titleLabel;
    [view addSubview:titleLabel];
    
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 45 - 150, 15, 150, 20)];
    rightLabel.text = model.rightLabel;
    [view addSubview:rightLabel];
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    return view;
}



#pragma mark ----TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 100;
    }else{
        return 50;
    }
    return 0;
}
@end
