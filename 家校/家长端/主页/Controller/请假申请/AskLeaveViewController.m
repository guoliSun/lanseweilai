//
//  AskLeaveViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/17.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "AskLeaveViewController.h"
#import "SegmentView.h"
#import "ApplyHistoryTableViewCell.h"
#import "MJRefresh.h"
#import "ApplyModel.h"
#import "DaysSelectView.h"
#import "SDRefresh.h"
@interface AskLeaveViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITextViewDelegate,CNPPopupControllerDelegate>
{
    UIScrollView *_applyScrollView;
    UITableView *_historyTableView;
    UIButton *_apply_button;//申请提交
    UIView *_apply_button_view;//申请提交页面的底部的view
    //-----申请------
    UILabel *_apply_username;//学生姓名
    UILabel *_apply_startTime;//请假开始时间
    UILabel *_apply_endTime;//请假结束时间
    UILabel *_label1;
    NSMutableArray *_infoArr;//数据信息
    UITextView *_apply_resonTextView;//请假原因
    float _apply_height;//整体高度
    NSInteger _number;
    //-----历史------
}
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic,weak)SDRefreshFooterView *refreshFooter;

@end

@implementation AskLeaveViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
    
    
}

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        
        self.title = @"请假申请";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        _apply_height = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    _number = 6 ;
    [self createScrollerViewAndHistoryTableView];
    [self createApplyButton];
    _applyScrollView.contentSize = CGSizeMake(kScreenWidth, 400);
    [self createSegmentView];
}



#pragma mark ----返回按钮
- (void)doBack:(UIButton *)sender{
    _applyScrollView.transform = CGAffineTransformIdentity;
    
    CGRect frame = _historyTableView.frame;
    frame.origin.x = _applyScrollView.right;
    _historyTableView.frame = frame;
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----顶部选择框（申请，历史）1.
- (void)createSegmentView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 65)];
    view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    
    SegmentView *segmentV = [[SegmentView alloc]initWithFrame:CGRectMake(20,  12.5, kScreenWidth - 40, 40) withTitleArray:@[@"申请",@"历史"]];
    [view addSubview:segmentV];
    segmentV.layer.masksToBounds = YES;
    segmentV.layer.cornerRadius = 5;
    __weak AskLeaveViewController *weakAskVC = self;
    [segmentV setSegmentBlock:^(NSInteger index) {
       
        __strong AskLeaveViewController *strongAskVC = weakAskVC;
        [strongAskVC segmentBlockWithIndex:index];
       
    }];
    [self.view addSubview:view];
}

#pragma mark ----segment block的方法
- (void)segmentBlockWithIndex:(NSInteger )index{
    if (index == 0) {
       
        
        _historyTableView.hidden = YES;
        _applyScrollView.hidden = NO;
        _apply_button.hidden = NO;
        
    }else{
        [_historyTableView.header beginRefreshing];
        _historyTableView.hidden = NO;
        _applyScrollView.hidden = YES;
        _apply_button.hidden = YES;
    }
}
#pragma mark ----创建申请和历史页面
- (void)createScrollerViewAndHistoryTableView{

    _historyTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 , kScreenWidth, kScreenHeight  - 64)];
    _historyTableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    _historyTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _historyTableView.dataSource = self;
    _historyTableView.delegate = self;
    _historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    
    [refreshFooter addToScrollView:_historyTableView];
    
    _refreshFooter = refreshFooter;
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
   // [self setupSDRefresh];
    [self.view addSubview:_historyTableView];
    _historyTableView.hidden = YES;
    
    
    _applyScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0,  64  + 65, kScreenWidth, kScreenHeight - 64 - 50 - 10 )];
    _applyScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_applyScrollView];
    
    //--------申请的方法-------
    [self createApplyUserName];
    [self createApplyInfo];
    
}
#pragma mark ----上拉加载
- (void)footerRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _number += 6;
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *studentDic = [accountDefaults objectForKey:@"studentInfo"];
        NSString *url = [NSString stringWithFormat:ApplyHistory,[studentDic objectForKey:@"studentId"],@"6",@"1"];
        NSString * encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [AFNetManager postRequestWithURL:encodingString withParameters:nil success:^(id response) {
            
            NSArray *arr = [response objectForKey:@"results"];
            _infoArr = [[NSMutableArray alloc]init];
            for (int i = 0; i < arr.count; i++) {
                [_infoArr addObject:arr[i]];
            }
            [_historyTableView reloadData];
        }];
        [_refreshFooter endRefreshing];
    });

    
}
#pragma mark ----下拉刷新
- (void)loadNewData{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *studentDic = [accountDefaults objectForKey:@"studentInfo"];
        NSString *url = [NSString stringWithFormat:ApplyHistory,[studentDic objectForKey:@"studentId"],@"6",@"1"];

        NSString * encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [AFNetManager postRequestWithURL:encodingString withParameters:nil success:^(id response) {
            
            NSArray *arr = [response objectForKey:@"results"];
            _infoArr = [[NSMutableArray alloc]init];
            for (int i = 0; i < arr.count; i++) {
                [_infoArr addObject:arr[i]];
            }
            [_historyTableView reloadData];
        }];
        [_historyTableView.header endRefreshing];
    });
}

#pragma mark ----  申请页面的提交
- (void)createApplyButton{
    _apply_button_view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 64, kScreenWidth, 64)];
    _apply_button_view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_apply_button_view];
    
    _apply_button = [[UIButton alloc]initWithFrame:CGRectMake(45, 0, kScreenWidth - 90, 44)];
    _apply_button.layer.masksToBounds = YES;
    _apply_button.layer.cornerRadius = 5;
    [_apply_button setTitle:@"提交" forState:UIControlStateNormal];
    [_apply_button setBackgroundColor:[UIColor colorWithRed:0.25 green:0.7 blue:0.96 alpha:1]];
    [_apply_button addTarget:self action:@selector(applyAct:) forControlEvents:UIControlEventTouchUpInside];
   [_apply_button_view addSubview:_apply_button];
}

- (void)applyAct:(UIButton *)sender{
    if (_apply_resonTextView.text.length == 0) {
        [self showPopupWithStyle:CNPPopupStyleCentered WithNumber:@"请假原因不能为空"];
        return;
    }
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *studentDic = [accountDefaults objectForKey:@"studentInfo"];
    NSDictionary *userInfoDic = [accountDefaults objectForKey:@"userInfo"];
    NSString *url = [NSString stringWithFormat:ApplyUrl,[userInfoDic objectForKey:@"userId"],[studentDic objectForKey:@"studentId"],_apply_startTime.text,_apply_endTime.text,_apply_resonTextView.text];
    NSString * encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [AFNetManager postRequestWithURL:encodingString withParameters:nil success:^(id response) {
         [self.view endEditing:YES];
        [self showPopupWithStyle:CNPPopupStyleCentered WithNumber:[response objectForKey:@"msg"]];
    }];
}

#pragma mark ----绘制一条横线
- (void)drowViewWithheight:(float)height{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth, 1)];
    view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] ;
    [_applyScrollView addSubview:view];
}

- (void)drowViewWithheight1:(float)height{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth, 2)];
    view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] ;
    [_applyScrollView addSubview:view];
}


//----------------申请--------------------
#pragma mark ----创建顶部学生姓名
- (void)createApplyUserName{
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2:)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    tap1.delegate = self;
    [view addGestureRecognizer:tap1];
    view.backgroundColor = [UIColor whiteColor];
    [_applyScrollView addSubview:view];
    
    //用户头像
    UIImageView *userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 17.5, 15, 15)];
    userImageView.image = [UIImage imageNamed:@"apply_userimage"];
    [view addSubview:userImageView];
    //用户名称
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 15, 80, 20)];
    nameLabel.text = @"学生姓名:";
    nameLabel.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1];
    nameLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:nameLabel];
    
    _apply_username = [[UILabel alloc]initWithFrame:CGRectMake(45 + 80 , 15, 60, 20)];
    _apply_username.text = @"孙国立";
    _apply_username.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1];
    _apply_username.font = [UIFont systemFontOfSize:16];
    [view addSubview:_apply_username];
    
    [self drowViewWithheight1:50];
    
    _apply_height += 52;
}

#pragma mark ----申请信息
- (void)createApplyInfo{
    float height = 20;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _apply_height , kScreenWidth, 200)];
    view.backgroundColor = [UIColor whiteColor];
    [_applyScrollView addSubview:view];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2:)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    tap1.delegate = self;
    [view addGestureRecognizer:tap1];
    //时间头像
    UIImageView *timeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 25, 25)];
    timeImageView.image = [UIImage imageNamed:@"applicationforleave_date"];
    [view addSubview:timeImageView];
    //时间名称
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 12, 150, 20)];
    timeLabel.text = @"选择请假时间:";
    timeLabel.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1];
    timeLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:timeLabel];
    
    height += 40;
    //开始时间
    UILabel *startTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, height  , 20, 20)];
    startTimeLabel.text = @"从";
    startTimeLabel.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1];
    startTimeLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:startTimeLabel];
    UIView *startView = [[UIView alloc]initWithFrame:CGRectMake(45 + 25, height  - 5, 185 * ScaleWidth, 30)];
    startView.layer.masksToBounds = YES;
    startView.layer.cornerRadius = 5;
    startView.layer.borderWidth = 1;
    startView.layer.borderColor = [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]CGColor];
    [view addSubview:startView];
    
    _apply_startTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150 * ScaleWidth, 20)];
    _apply_startTime.font = [UIFont systemFontOfSize:16];
    _apply_startTime.text = @"请输入开始时间";
    _apply_startTime.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1];
    //_apply_startTime.backgroundColor = [UIColor yellowColor];
    [startView addSubview:_apply_startTime];
    
    UIButton *startTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(160 * ScaleWidth, 5, 30, 30)];
    UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 10, 10)];
    imageV1.image = [UIImage imageNamed:@"Unknown"];
    imageV1.userInteractionEnabled = YES;
    [startTimeBtn addSubview:imageV1];
    //[startTimeBtn setImage:[UIImage imageNamed:@"Unknown"] forState:UIControlStateNormal];
    [startTimeBtn addTarget:self action:@selector(timeSelectAct:) forControlEvents:UIControlEventTouchUpInside];
    startTimeBtn.tag = 101;
    [startView addSubview:startTimeBtn];
    
    height += 50;
    //结束时间
    UILabel *endTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, height, 20, 20)];
    endTimeLabel.text = @"到";
    endTimeLabel.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1];
    endTimeLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:endTimeLabel];
    
    UIView *endView = [[UIView alloc]initWithFrame:CGRectMake(45 + 25, height  - 5, 185 * ScaleWidth, 30)];
    endView.layer.masksToBounds = YES;
    endView.layer.cornerRadius = 5;
    endView.layer.borderWidth = 1;
    endView.layer.borderColor = [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]CGColor];;
    [view addSubview:endView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(55 + 30 + 185 * ScaleWidth, height  - 5, 90, 26)];
    label.text = @"(含该日)";
    label.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1];
    label.font = [UIFont systemFontOfSize:16];
    [view addSubview:label];
    
    _apply_endTime = [[UILabel alloc]initWithFrame:CGRectMake(15,5, 140 * ScaleWidth, 20)];
    _apply_endTime.font = [UIFont systemFontOfSize:16];
    _apply_endTime.text = @"请输入终止时间";
    _apply_endTime.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1];
    //_apply_endTime.backgroundColor = [UIColor yellowColor];
    [endView addSubview:_apply_endTime];
    
    UIButton *endTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(160 * ScaleWidth, 5, 30, 30)];
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 10, 10)];
    imageV2.image = [UIImage imageNamed:@"Unknown"];
    imageV2.userInteractionEnabled = YES;
    [endTimeBtn addSubview:imageV2];
    [endTimeBtn addTarget:self action:@selector(timeSelectAct:) forControlEvents:UIControlEventTouchUpInside];
    endTimeBtn.tag = 102;
    //[endTimeBtn setImage:[UIImage imageNamed:@"Unknown"] forState:UIControlStateNormal];
    [endView addSubview:endTimeBtn];
    
    height += 50;
    
    //请假原因
    _apply_resonTextView = [[UITextView alloc]initWithFrame:CGRectMake(40, height , kScreenWidth - 80, 150 * ScaleHeight)];
    
   _label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 160, 20)];
    _label1.text = @"请填写请假原因";
    _label1.font = [UIFont systemFontOfSize:16];
    _label1.textColor = [UIColor colorWithRed:0.7843 green:0.7843 blue:0.7843 alpha:1];
    [_apply_resonTextView addSubview:_label1];
    _apply_resonTextView.delegate = self;
    _apply_resonTextView.layer.masksToBounds = YES;
    _apply_resonTextView.layer.cornerRadius = 5;
    _apply_resonTextView.layer.borderWidth = 1;
    _apply_resonTextView.font = [UIFont systemFontOfSize:16];
    _apply_resonTextView.layer.borderColor = [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] CGColor];
    
    [view addSubview:_apply_resonTextView];
    
}

- (void)timeSelectAct:(UIButton *)sender{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:view];
    
    DaysSelectView *dayView = [[DaysSelectView alloc]initWithFrame:CGRectMake(10, 64 + (kScreenHeight - 64 - 500) / 2, kScreenWidth - 20, 500)];
    [dayView setBlock:^(NSString *dayString) {
        if (sender.tag == 101) {
            if (![dayString isEqualToString:@"0"]) {
                _apply_startTime.text = dayString;
            }
        }
        if (sender.tag == 102) {
            if (![dayString isEqualToString:@"0"]) {
                _apply_endTime.text = dayString;
            }
        }
        [view removeFromSuperview];
    }];
    [view addSubview:dayView];
    
    [self.view addSubview:view];
    
    
}

#pragma mark ----textviewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        _label1.hidden = NO;
    }else{
        _label1.hidden = YES;
    }
}
//----------------历史--------------------
#pragma mark ----UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_infoArr.count){
        return _infoArr.count ;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"apply_history_cell";
    ApplyHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ApplyHistoryTableViewCell" owner:self options:nil] lastObject];
        
    }
    cell.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    
    ApplyModel *model = [[ApplyModel alloc]init];
    model.startTime = [_infoArr[indexPath.row] objectForKey:@"startDate"];
    model.state = [_infoArr[indexPath.row] objectForKey:@"state"];
    model.endTime = [_infoArr[indexPath.row] objectForKey:@"endDate"];
    model.applyTime = [_infoArr[indexPath.row] objectForKey:@"createDate"];
    
    cell.model = model;
    

    return cell;
}

#pragma mark ----UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 105;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#warning -----点击跳转
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)tapAction2:(UITapGestureRecognizer *)tap{
    
    if (tap.numberOfTapsRequired == 1) {
        [self.view endEditing:YES];
    }
}


#pragma mark  ----- 自定义提示框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle WithNumber:(NSString *)info {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"请假申请提示" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:info attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        [self.popupController dismissPopupControllerAnimated:YES];
        _apply_resonTextView.text = nil;
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
