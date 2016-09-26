//
//  StatusSelectViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/24.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "StatusSelectViewController.h"
#import "StatysSelectTableViewCell.h"
@interface StatusSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *teacherView;

@end

@implementation StatusSelectViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份选择";
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //self.interactivePopGestureRecognizer.enabled = NO;
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    //重新定义返回按钮
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.navigationBarHidden = NO;
    [self createTopView];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64 + 62, kScreenWidth, kScreenHeight)];
    _tableView.scrollEnabled = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)createTopView{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 60)];
    UILabel *titlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 20)];
    titlabel.text = @"您有一下多个身份,请选择:";
    titlabel.font = [UIFont systemFontOfSize:14];
    titlabel.textColor = [UIColor colorWithRed:130 / 255.0 green:130 / 255.0 blue:130 / 255.0 alpha:1];
    [view addSubview:titlabel];
    view.backgroundColor = [UIColor redColor];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)tapAction1:(UITapGestureRecognizer *)tap{
    
    if (tap.numberOfTapsRequired == 1) {
        
        _block(1);
        
    }
    
}



- (void)tapAction2:(UITapGestureRecognizer *)tap{
    
    if (tap.numberOfTapsRequired == 1) {
        
        _block(2);
        
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"status_cell";
    StatysSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        if(indexPath.row == 0){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"StatysSelectTableViewCell" owner:self options:nil] firstObject];
        }else{
            cell = [[[NSBundle mainBundle]loadNibNamed:@"StatysSelectTableViewCell" owner:self options:nil] lastObject];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        _block(1); //家长端
    }else{
        _block(2);//教师端
    }
}
@end
