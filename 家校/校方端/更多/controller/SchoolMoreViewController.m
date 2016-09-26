//
//  SchoolMoreViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/24.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "SchoolMoreViewController.h"
#import "SchoolMoreTableViewCell.h"
#import "NotifyViewController.h"
#import "ExerciseViewController.h"
#import "WeekFoodViewController.h"
#import "SchoolSetUpViewController.h"
@interface SchoolMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_imageArr;
    NSArray *_titleArr;
}
@end

@implementation SchoolMoreViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        //设置控制器的 题目(导航栏) 标签图片(标签栏)
        self.title = @"更多";
        self.view.backgroundColor = [UIColor whiteColor];
        self.tabBarItem.image = [UIImage imageNamed:@"more_school"];
        self.tabBarItem.title = @"更多";
    }
    return self;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArr = @[@"noticedeclare",@"excitingactivity",@"dietmenu",@"setting"];
    _titleArr = @[@"通知公告",@"精彩活动",@"每周食谱",@"设置"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.scrollEnabled = NO;
     _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifiye = @"school_more_cell";
    SchoolMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiye];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SchoolMoreTableViewCell" owner:self options:nil] lastObject];
    }
    cell.logoImage.image = [UIImage imageNamed:_imageArr[indexPath.row]];
    cell.titleLabel.text = _titleArr[indexPath.row];
     cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)setName:(NSString *)name{
    _name = name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",_name);
    if (indexPath.row == 0) {
        NotifyViewController *nvc = [[NotifyViewController alloc]init];
        nvc.index = 1;
        [self.navigationController pushViewController:nvc animated:YES];
    }
    if(indexPath.row == 1){
        ExerciseViewController *eVC = [[ExerciseViewController alloc]init];
        [self.navigationController pushViewController:eVC animated:YES];
    }
    if (indexPath.row == 2) {
        WeekFoodViewController *wfVC = [[WeekFoodViewController alloc]init];
        [self.navigationController pushViewController:wfVC animated:YES];
    }
    if (indexPath.row == 3) {
        SchoolSetUpViewController *ssuVC = [[SchoolSetUpViewController alloc]init];
        [ssuVC setBlock:^(NSInteger index) {
            _block(index);
        }];
        ssuVC.index = 1;
        [self.navigationController pushViewController:ssuVC animated:YES];
    }
}

@end
