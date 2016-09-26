//
//  SchoolAttRecordViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/24.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "SchoolAttRecordViewController.h"
#import "SchoolAskTableViewCell.h"
#import "AskInfoViewController.h"
#import "SchoolARecordViewController.h"
@interface SchoolAttRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UIScrollView *_countScrollerView;//每日考勤统计
    UITableView *_askTableView;//请假
    UIScrollView *_findScrollerView;//统计查询
 
    //-----每日考勤------
    UILabel *_count_timeLabel;//选择时间
    UILabel *_count_normalLabel; //正常天数
    UILabel *_count_offLabel;//缺勤天数
    UILabel *_count_askLabel;//请假天数
    //------统计查询-----
    UILabel *_find_timeLabel;//选择时间
    UILabel *_find_normalLabel; //正常天数
    UILabel *_find_offLabel;//缺勤天数
    UILabel *_find_askLabel;//请假天数
    
    float _count_height;//高度
    float _find_height;
}
@end

@implementation SchoolAttRecordViewController

- (instancetype)init{
    
    if (self = [super init]) {
        
        //设置控制器的 题目(导航栏) 标签图片(标签栏)
        self.title = @"考勤";
        self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
        self.tabBarItem.image = [UIImage imageNamed:@"checkonwork_school"];
        self.tabBarItem.title = @"考勤";
    }
    return self;
    
}


- (void)viewWillDisappear:(BOOL)animated{
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSegmentView];
    [self createTodayViewAndCountTableView];
    
    
    _countScrollerView.contentSize = CGSizeMake(kScreenWidth, _count_height);
    _findScrollerView.contentSize = CGSizeMake(kScreenWidth, _find_height);
}

#pragma mark ----返回按钮
- (void)doBack:(UIButton *)sender{
   
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ----顶部选择框（今日考勤，统计）1.
- (void)createSegmentView{
    SegmentView *segmentV = [[SegmentView alloc]initWithFrame:CGRectMake(10, 64 + 12.5, kScreenWidth - 20, 40) withTitleArray:@[@"每日考勤",@"请假申请",@"统计查询"]];
    segmentV.layer.masksToBounds = YES;
    segmentV.layer.cornerRadius = 5;
    __weak SchoolAttRecordViewController *weakARecordVC = self;
    [segmentV setSegmentBlock:^(NSInteger index) {
        
        __strong SchoolAttRecordViewController *strongARecordVC = weakARecordVC;
        [strongARecordVC segmentBlockWithIndex:index];
        
    }];
    [self.view addSubview:segmentV];
}

#pragma mark ----segment block的方法
- (void)segmentBlockWithIndex:(NSInteger )index{
        CGRect frame = _countScrollerView.frame;
        frame.origin.x = -kScreenWidth * index;
        _countScrollerView.frame = frame;
        
        CGRect frame1 = _askTableView.frame;
        frame1.origin.x = _countScrollerView.right;
        _askTableView.frame = frame1;
        
        CGRect frame2 = _findScrollerView.frame;
        frame2.origin.x = _askTableView.right;
        _findScrollerView.frame = frame2;
}

#pragma mark ----绘制一条横线

- (UIView *)drowViewWithheight1:(float)height{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth, 1)];
    view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] ;
    return view;
}



#pragma mark -----创建每日考勤、请假申请、统计查询
- (void)createTodayViewAndCountTableView{
    //每日统计
    _countScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64 + 65, kScreenWidth, kScreenHeight - 64 - 65 - 49 )];
        //水平
    _countScrollerView.showsHorizontalScrollIndicator = NO;
    //垂直
    _countScrollerView.showsVerticalScrollIndicator = YES;
    _countScrollerView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_countScrollerView];
    [_countScrollerView addSubview:[self createHeaderView]];
    [self countInfo];
    
    //请假申请
    _askTableView = [[UITableView alloc]initWithFrame:CGRectMake(_countScrollerView.right, 64 + 65, kScreenWidth, kScreenHeight - 64 - 65 - 49 )];
    _askTableView.tableFooterView = [[UIView alloc]init];
    _askTableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    _askTableView.separatorStyle = NO;
    [self.view addSubview:_askTableView];
    _askTableView.dataSource = self;
    _askTableView.delegate = self;
    
    //统计查询
    _findScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(_askTableView.right, 64 + 65, kScreenWidth, kScreenHeight - 64 - 65 - 49 )];
    _findScrollerView.showsHorizontalScrollIndicator = NO;
    //垂直
    _findScrollerView.showsVerticalScrollIndicator = YES;
    _findScrollerView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_findScrollerView];
    [_findScrollerView addSubview:[self createHeaderView1]];
    [self countInfo1];
    
}

//-----------每日考勤---------------
#pragma makr ----创建头部的选择按钮
- (UIView *)createHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    //上层最外部的view
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    topView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:topView];
    //上层里面的view
    UIView *topInView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 240) / 2, 15, 240, 30)];
    [topView addSubview:topInView];
    UIImageView *topBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(45, 0, 140, 30)];
    topBgImageView.image = [UIImage imageNamed:@"yuanjiaojuxing"];
    [topInView addSubview:topBgImageView];
    
    //选择时间按钮
    UIButton *selectTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 10, 10, 10)];
    selectTimeButton.tag = 101;
    [selectTimeButton addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    [selectTimeButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [topInView addSubview:selectTimeButton];
    
    _count_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 5, 120, 20)];
    _count_timeLabel.text = @"2016年9月";
    _count_timeLabel.font = [UIFont systemFontOfSize:16];
    _count_timeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
    [topInView addSubview:_count_timeLabel];
    
    
    //今日按钮
//    UIButton *todayBtn = [[UIButton alloc]initWithFrame:CGRectMake(topBgImageView.right + 10, topBgImageView.top + 5, 50, 20)];
//    todayBtn.layer.masksToBounds = YES;
//    todayBtn.layer.cornerRadius = 5;
//    [todayBtn setTitle:@"今日" forState:UIControlStateNormal];
//    [todayBtn setBackgroundColor:[UIColor colorWithRed:0 green:0.709 blue:0.953 alpha:1]];
//    todayBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    todayBtn.titleLabel.textColor = [UIColor whiteColor];
//    [topInView addSubview:todayBtn];
    //绘制一条横线
    
    [topView addSubview:  [self drowViewWithheight1:60]];
    
    
    //下面的view
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 62, kScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:bottomView];
    
    for (int i = 0; i < 3 ; i++) {
        NSArray *imageNameArr = @[@"statistics_normaled",@"statistics_absenced",@"statistics_leaved"];
        NSArray *nameArr = @[@"正常:",@"缺勤:",@"请假:"];
        UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(i * kScreenWidth / 3, 15, kScreenWidth / 3, 20)];
        [bottomView addSubview:centerView];
        
        
        UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(centerView.width / 2 - 50, 0, 100, 20)];
        [centerView addSubview:infoView];
        if (i == 0) {
            CGRect frame = infoView.frame;
            frame.origin.x = centerView.width - 100;
            infoView.frame = frame;
        }
        if (i == 2) {
            CGRect frame = infoView.frame;
            frame.origin.x = 0;
            infoView.frame = frame;
        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 10, 10)];
        imageView.image =  [UIImage imageNamed:imageNameArr[i]];
        [infoView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 40, 20)];
        label.text = nameArr[i];
        label.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
        label.font = [UIFont systemFontOfSize:16];
        [infoView addSubview:label];
        
        //UILabel *_count_normalLabel; //正常天数
        //UILabel *_count_offLabel;//缺勤天数
        //UILabel *_count_askLabel;//请假天数
        if (i == 0) {
            _count_normalLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, 40, 20)];
            _count_normalLabel.text = @"30天";
            _count_normalLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
            _count_normalLabel.font = [UIFont systemFontOfSize:16];
            [infoView addSubview:_count_normalLabel];
        }
        
        if (i == 1) {
            _count_offLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, 40, 20)];
            _count_offLabel.text = @"30天";
            _count_offLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
            _count_offLabel.font = [UIFont systemFontOfSize:16];
            [infoView addSubview:_count_offLabel];
        }
        
        if (i == 2) {
            _count_askLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, 40, 20)];
            _count_askLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
            _count_askLabel.text = @"30天";
            _count_askLabel.font = [UIFont systemFontOfSize:16];
            [infoView addSubview:_count_askLabel];
        }
    }
    //绘制一条横线
    [bottomView addSubview: [self drowViewWithheight1:50]];
    _count_height += 110;
    return headerView;

}
#pragma mark ----创建底部的详细信息
- (void)countInfo{
    UIImageView *countBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, _count_height + 20, kScreenWidth - 40, 200)];
    countBgImageView.image = [UIImage imageNamed:@"statistics_border3"];
    [_countScrollerView addSubview:countBgImageView];
    
    UIImageView *zeroImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, (countBgImageView.width - 20) / 3 + 20, 40)];
    zeroImageView1.image = [UIImage imageNamed:@"statistics_border2"];
    UILabel *studentNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, zeroImageView1.width, 20)];
    studentNameLabel.text = @"学生";
    studentNameLabel.textAlignment = NSTextAlignmentCenter;
    studentNameLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
    [zeroImageView1 addSubview:studentNameLabel];
    [countBgImageView addSubview:zeroImageView1];
    
    UIImageView *zeroImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(zeroImageView1.right + 5, 5, (countBgImageView.width - 20) / 3 - 10, 40)];
    zeroImageView2.image = [UIImage imageNamed:@"statistics_border2"];
    [countBgImageView addSubview:zeroImageView2];
    UILabel *zeroGotimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, zeroImageView2.width, 20)];
    zeroGotimeLabel.text = @"到校";
    zeroGotimeLabel.textAlignment = NSTextAlignmentCenter;
    zeroGotimeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
    [zeroImageView2 addSubview:zeroGotimeLabel];
    
    UIImageView *zeroImageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(zeroImageView2.right + 5, 5, (countBgImageView.width - 20) / 3 - 10, 40)];
    zeroImageView3.image = [UIImage imageNamed:@"statistics_border2"];
    [countBgImageView addSubview:zeroImageView3];
    UILabel *zeroOuttimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, zeroImageView3.width, 20)];
    zeroOuttimeLabel.text = @"离校";
    zeroOuttimeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
    zeroOuttimeLabel.textAlignment = NSTextAlignmentCenter;
    [zeroImageView3 addSubview:zeroOuttimeLabel];
    //循环创建每一天的情况
    float height = 45;
    for (int i = 0; i < 30; i ++) {
        
        UIImageView *timeImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, height, (countBgImageView.width - 20) / 3 + 20, 40)];
        timeImageView1.image = [UIImage imageNamed:@"statistics_border2"];
        [countBgImageView addSubview:timeImageView1];
        UILabel *counttimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, timeImageView1.width, 20)];
        counttimeLabel.text = @"陈晓军";
        counttimeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
        counttimeLabel.textAlignment = NSTextAlignmentCenter;
        [timeImageView1 addSubview:counttimeLabel];
        
        
        
        UIImageView *timeImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(timeImageView1.right + 5, height, (countBgImageView.width - 20) / 3 - 10, 40)];
        timeImageView2.image = [UIImage imageNamed:@"statistics_border2"];
        [countBgImageView addSubview:timeImageView2];
        UILabel *timeGotimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, timeImageView2.width, 20)];
        timeGotimeLabel.text = @"09:07";
        timeGotimeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
        timeGotimeLabel.textAlignment = NSTextAlignmentCenter;
        [timeImageView2 addSubview:timeGotimeLabel];
        
        UIImageView *timeImageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(timeImageView2.right + 5, height, (countBgImageView.width - 20) / 3 - 10, 40)];
        timeImageView3.image = [UIImage imageNamed:@"statistics_border2"];
        [countBgImageView addSubview:timeImageView3];
        UILabel *timeOuttimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, timeImageView3.width, 20)];
        timeOuttimeLabel.text = @"09:56";
        timeOuttimeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
        timeOuttimeLabel.textAlignment = NSTextAlignmentCenter;
        [timeImageView3 addSubview:timeOuttimeLabel];
        height += 43;
    }
    
    _count_height += height + 40;
    CGRect frame = countBgImageView.frame;
    frame.size.height = height;
    countBgImageView.frame = frame;
}

- (void)btnAct:(UIButton *)sender{
    
    NSLog(@"123");
}

#pragma mark ----统计查询
- (UIView *)createHeaderView1{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    //上层最外部的view
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    topView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:topView];
    //上层里面的view
    UIView *topInView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 200) / 2, 15, 200, 30)];
    [topView addSubview:topInView];
    UIImageView *topBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 0, 130, 30)];
    topBgImageView.image = [UIImage imageNamed:@"yuanjiaojuxing"];
    [topInView addSubview:topBgImageView];
    
    //选择时间按钮
    UIButton *selectTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(150, 10, 10, 10)];
    selectTimeButton.tag = 101;
    [selectTimeButton addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    [selectTimeButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [topInView addSubview:selectTimeButton];
    //点击时间变小
    UIButton *topLeftButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 6, 10, 17)];
    topLeftButton.tag = 102;
    [topLeftButton addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    [topLeftButton setImage:[UIImage imageNamed:@"leftarrow_date"] forState:UIControlStateNormal];
    [topInView addSubview:topLeftButton];
    //点击时间变大
    UIButton *topRightButton = [[UIButton alloc]initWithFrame:CGRectMake(205 - 20, 6, 10, 17)];
    topRightButton.tag = 103;
    [topRightButton addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    [topRightButton setImage:[UIImage imageNamed:@"rightarrow_date"] forState:UIControlStateNormal];
    [topInView addSubview:topRightButton];
    
    _find_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 130, 20)];
    _find_timeLabel.text = @"2016年9月";
    _find_timeLabel.font = [UIFont systemFontOfSize:16];
    _find_timeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
    [topInView addSubview:_find_timeLabel];
    //绘制一条横线
    
    [topView addSubview:  [self drowViewWithheight1:60]];
    
    
    _find_height += 60;
    return headerView;
}
#pragma mark ----创建底部的详细信息
- (void)countInfo1{
    UIImageView *countBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, _find_height + 20, kScreenWidth - 40, 200)];
    countBgImageView.userInteractionEnabled = YES;
    countBgImageView.image = [UIImage imageNamed:@"statistics_border3"];
    [_findScrollerView addSubview:countBgImageView];
    
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, countBgImageView.width - 6, 50)];
    topImageView.image = [UIImage imageNamed:@"statistics_border"];
    [countBgImageView addSubview:topImageView];
    NSArray *titleArr = @[@"学生姓名",@"正常",@"缺勤",@"请假",@"详情"];
    float height = 56;
    for (int k = 0; k < 5; k++) {
        if(k == 0){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, topImageView.width / 5 + 20, 20)];
            label.text = titleArr[k];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:16];
            [topImageView addSubview:label];
        }else{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake( topImageView.width / 5 + 20 + (k - 1) * (topImageView.width - 20 - topImageView.width / 5) / 4, 15, (topImageView.width - 20 - topImageView.width / 5) / 4, 20)];
            label.text = titleArr[k];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:16];
            [topImageView addSubview:label];
        }
    }
    
    for (int i = 0; i < 20; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(3, height, countBgImageView.width - 6, 50)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:@"statistics_border"];
        [countBgImageView addSubview:imageView];
        height += 53;
        NSArray *infoArr = @[@"陈晓军",@"0",@"32",@"0"];
        for (int k = 0; k < 5; k++) {
            if(k == 0){
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, topImageView.width / 5 + 20, 20)];
                label.text = infoArr[k];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:16];
                [imageView addSubview:label];
            }else if(k < 4){
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake( topImageView.width / 5 + 20 + (k - 1) * (topImageView.width - 20 - topImageView.width / 5) / 4, 15, (topImageView.width - 20 - topImageView.width / 5) / 4, 20)];
                label.text = infoArr[k];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:16];
                [imageView addSubview:label];
            }
            if(k == 4){
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake( topImageView.width / 5 + 20 + (k - 1) * (topImageView.width - 20 - topImageView.width / 5) / 4 + 16, 15, (topImageView.width - 20 - topImageView.width / 5) / 4 - 32, 20)];
                [button setBackgroundImage:[UIImage imageNamed:@"askRight"] forState:UIControlStateNormal];
                button.tag = 10000+i;
                [button addTarget:self action:@selector(studentInfoAct:) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:button];
            }
        }
    }
    _find_height += height + 40;
    CGRect frame = countBgImageView.frame;
    frame.size.height = height + 3;
    countBgImageView.frame = frame;
}

- (void)studentInfoAct:(UIButton *)sender{
    NSLog(@"12312");
    SchoolARecordViewController *sarVC = [[SchoolARecordViewController alloc]init];
    [self.navigationController pushViewController:sarVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----tableViewdatasouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"apply_school_cell";
    SchoolAskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SchoolAskTableViewCell" owner:self options:nil] lastObject];
        
    }
    cell.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    
    if (indexPath.row == 0) {
        cell.statusImageView.image = [UIImage imageNamed:@"nopermit"];
    }
    if (indexPath.row == 1) {
        cell.statusImageView.image = [UIImage imageNamed:@"permitted"];
    }
    if (indexPath.row == 2) {
        cell.statusImageView.image = [UIImage imageNamed:@"permitting"];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

#pragma mark ----UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 105;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#warning -----点击跳转
    AskInfoViewController *askVC = [[AskInfoViewController alloc]init];
    [self.navigationController pushViewController:askVC animated:YES];
}


@end
