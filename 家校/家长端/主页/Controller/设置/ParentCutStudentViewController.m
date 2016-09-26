//
//  ParentCutStudentViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/26.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "ParentCutStudentViewController.h"
#import "ParentCutStudentTableViewCell.h"
@interface ParentCutStudentViewController ()<UITableViewDelegate,UITableViewDataSource,CNPPopupControllerDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_infoArr;
}
@property (nonatomic, strong) CNPPopupController *popupController;
@end


@implementation ParentCutStudentViewController

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"切换学生";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}

- (void)doBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic =  [accountDefaults objectForKey:@"userInfo"];
    NSString *userId =  [dic objectForKey:@"userId"];
    
    NSString *url = [NSString stringWithFormat:StudentListUrl,userId];
    [AFNetManager postRequestWithURL:url withParameters:nil success:^(id response) {
        NSArray *arr = [response objectForKey:@"results"];
        _infoArr = [[NSMutableArray alloc]init];
        int number = 0;
        for(int i = 0;i<arr.count;i++){
            NSDictionary *dic = arr[i];
            if ([[dic objectForKey:@"isDefault"] intValue] == 1) {
                number = i;
                [_infoArr addObject:arr[i]];
            }
        }
        for (int i = 0; i < arr.count; i++) {
            if (i != number) {
                [_infoArr addObject:arr[i]];
            }
        }
        [_tableView reloadData];
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight )];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----tableViewDatasouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_infoArr.count) {
        return  _infoArr.count;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"pcutstudent_cell";
    ParentCutStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        if (indexPath.row == 0) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ParentCutStudentTableViewCell" owner:self options:nil] firstObject];
        }else{
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ParentCutStudentTableViewCell" owner:self options:nil] lastObject];
        }
    }
    cell.nowStudentNameLabel.text = [_infoArr[indexPath.row] objectForKey:@"studentName"];
    cell.selectStudentNameLabel.text = [_infoArr[indexPath.row] objectForKey:@"studentName"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark ----TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row != 0){
        NSDictionary *selectStudenDic= _infoArr[indexPath.row];
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *userInfoDic = [accountDefaults objectForKey:@"userInfo"];
        NSString *url = [NSString stringWithFormat:SelectStudent,[selectStudenDic objectForKey:@"studentId"],[userInfoDic objectForKey:@"parentId"]];
        [AFNetManager postRequestWithURL:url withParameters:nil success:^(id response) {
            
            NSDictionary *studentInfoDic = @{
                                             @"studentId":[_infoArr[indexPath.row] objectForKey:@"studentId"],
                                             @"studentName":[_infoArr[indexPath.row] objectForKey:@"studentName"],
                                             @"studentSchool":[_infoArr[indexPath.row] objectForKey:@"studentSchool"],
                                             @"studentClass":[_infoArr[indexPath.row] objectForKey:@"studentClass"],
                                             @"relation":[_infoArr[indexPath.row] objectForKey:@"relation"]};
            [accountDefaults setObject:studentInfoDic forKey:@"studentInfo"];
            if ([[response objectForKey:@"code"] integerValue] == 100) {
                [self showPopupWithStyle:CNPPopupStyleCentered WithSuccess:[response objectForKey:@"msg"]];
            }else{
                
            }
            
            
        }];
    }
}

- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle WithSuccess:(NSString *)info {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"学生切换提示" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:info attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        [self.popupController dismissPopupControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.attributedText = title;
    
    UILabel *lineOneLabel = [[UILabel alloc] init];
    lineOneLabel.numberOfLines = 0;
    lineOneLabel.attributedText = lineOne;
    self.popupController = [[CNPPopupController alloc] initWithContents:@[titleLabel, lineOneLabel, button]];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    [self.popupController presentPopupControllerAnimated:YES];
}

#pragma mark  ----- 自定义提示框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle WithNumber:(NSString *)info {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"密码修改提示" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:info attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        [self.popupController dismissPopupControllerAnimated:YES];
        
    };
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.attributedText = title;
    
    UILabel *lineOneLabel = [[UILabel alloc] init];
    lineOneLabel.numberOfLines = 0;
    lineOneLabel.attributedText = lineOne;
    self.popupController = [[CNPPopupController alloc] initWithContents:@[titleLabel, lineOneLabel, button]];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    [self.popupController presentPopupControllerAnimated:YES];
}


@end
