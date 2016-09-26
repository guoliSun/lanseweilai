//
//  ARecordViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/18.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "ARecordViewController.h"

@interface ARecordViewController ()<UIScrollViewDelegate>
{
    UIView *_todayView;//今日考勤背景
    UIScrollView *_countScrollerView;
    //-----今日考勤------
    UILabel *_today_goTime;//到校时间
    UILabel *_today_outTime;//离校时间
    //-----统计------
    UILabel *_count_timeLabel;//选择时间
    UILabel *_count_normalLabel; //正常天数
    UILabel *_count_offLabel;//缺勤天数
    UILabel *_count_askLabel;//请假天数
    float _count_height;//高度
}
@end

@implementation ARecordViewController

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor colorWithRed:0.932 green:0.945 blue:0.949 alpha:1];
        
        self.title = @"考勤";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        _count_height = 0;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    CGRect frame1 = _todayView.frame;
    frame1.origin.x = 0;
    _todayView.frame = frame1;
    CGRect frame = _countScrollerView.frame;
    frame.origin.x = _todayView.right;
    _countScrollerView.frame = frame;

}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
        
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup af ter loading the view.
    [self createSegmentView];
    [self createTodayViewAndCountTableView];
    [self createTodayInfo];
    
    _countScrollerView.contentSize = CGSizeMake(kScreenWidth, _count_height);
}

#pragma mark ----返回按钮
- (void)doBack:(UIButton *)sender{
    _todayView.transform = CGAffineTransformIdentity;
    CGRect frame = _countScrollerView.frame;
    frame.origin.x = _todayView.right;
    _countScrollerView.frame = frame;
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ----顶部选择框（今日考勤，统计）1.
- (void)createSegmentView{
    SegmentView *segmentV = [[SegmentView alloc]initWithFrame:CGRectMake(20, 64 + 12.5, kScreenWidth - 40, 40) withTitleArray:@[@"今日考勤",@"统计"]];
    segmentV.layer.masksToBounds = YES;
    segmentV.layer.cornerRadius = 5;
    __weak ARecordViewController *weakARecordVC = self;
    [segmentV setSegmentBlock:^(NSInteger index) {
        
        __strong ARecordViewController *strongARecordVC = weakARecordVC;
        [strongARecordVC segmentBlockWithIndex:index];
        
    }];
    [self.view addSubview:segmentV];
}

#pragma mark ----segment block的方法
- (void)segmentBlockWithIndex:(NSInteger )index{
    if (index == 0) {
        
        CGRect frame1 = _todayView.frame;
        frame1.origin.x = 0;
        _todayView.frame = frame1;
        CGRect frame = _countScrollerView.frame;
        frame.origin.x = _todayView.right;
        _countScrollerView.frame = frame;
        
        
    }else{
       
        CGRect frame1 = _todayView.frame;
        frame1.origin.x = -kScreenWidth;
        _todayView.frame = frame1;
        CGRect frame = _countScrollerView.frame;
        frame.origin.x = _todayView.right;
        _countScrollerView.frame = frame;
        
    }
}

#pragma mark ----绘制一条横线
- (void)drowViewWithheight:(float)height{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth, 2)];
    view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] ;
    [_todayView addSubview:view];
}
- (UIView *)drowViewWithheight1:(float)height{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth, 1)];
    view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] ;
    return view;
}



#pragma mark -----创建今日考勤和统计
- (void)createTodayViewAndCountTableView{
    _todayView = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + 65, kScreenWidth, kScreenHeight - 64 - 60)];
    _todayView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_todayView];
    
    _countScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(_todayView.right, 64 + 65, kScreenWidth, kScreenHeight - 64 - 65 )];
    //_CountTableView.backgroundColor = [UIColor yellowColor];
    //_CountTableView.tableHeaderView = [self createHeaderView];
    //水平
    _countScrollerView.showsHorizontalScrollIndicator = NO;
    //垂直
    _countScrollerView.showsVerticalScrollIndicator = YES;
    _countScrollerView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_countScrollerView];
    [_countScrollerView addSubview:[self createHeaderView]];
    [self countInfo];
}

//-----------今日考勤-------------
#pragma mark ----今日考勤的相关信息
- (void)createTodayInfo{
    float height = 0;
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth, 60)];
    timeView.backgroundColor = [UIColor whiteColor];
    //放置当前日期的label
    UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 140) / 2, 20 , 140, 20)];
    timeLable.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    timeLable.font = [UIFont systemFontOfSize:18];
    //获取今日的时间
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateString = [df stringFromDate:nowDate];
    timeLable.text = dateString;
    [timeView addSubview:timeLable];
    [_todayView addSubview:timeView];
    height += 60;
    //到校时间
    UIView *goView = [[UIView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth, 60)];
    goView.backgroundColor = [UIColor whiteColor];
    UIImageView *goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(timeLable.left - 3 , 20, 20, 20)];
    goImageView.contentMode = UIViewContentModeCenter;
    goImageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    goImageView.image = [UIImage imageNamed:@"checkonwork_kindergarden"];
    [goView addSubview:goImageView];
    UILabel *goLabelName = [[UILabel alloc]initWithFrame:CGRectMake(timeLable.left + 23 - 5 , 20, 50, 20)];
    goLabelName.text = @"到校:";
    goLabelName.font = [UIFont systemFontOfSize:18];
    goLabelName.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    [goView addSubview:goLabelName];
    
    _today_goTime = [[UILabel alloc]initWithFrame:CGRectMake(timeLable.left + 23 - 5 + 45, 20, 60, 20)];
    _today_goTime.text = @"9:20";
    _today_goTime.font = [UIFont systemFontOfSize:18];
    _today_goTime.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    [goView addSubview:_today_goTime];
    [_todayView addSubview:goView];
    
    
    //绘制一条横线
    height += 2;
    [self drowViewWithheight:height];
    height += 60;
    [self drowViewWithheight:height];
    height += 2;
    //离校时间
    UIView *outView = [[UIView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth, 60)];
    outView.backgroundColor = [UIColor whiteColor];
    UIImageView *outImageView = [[UIImageView alloc]initWithFrame:CGRectMake(timeLable.left - 3 , 20, 20, 20)];
    outImageView.contentMode = UIViewContentModeCenter;
    outImageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    outImageView.image = [UIImage imageNamed:@"checkonwork_leaveschool"];
    [outView addSubview:outImageView];
    UILabel *outLabelName = [[UILabel alloc]initWithFrame:CGRectMake(timeLable.left + 23 - 5 , 20, 50, 20)];
    outLabelName.text = @"离校:";
    outLabelName.font = [UIFont systemFontOfSize:18];
    outLabelName.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    [outView addSubview:outLabelName];
    
    _today_outTime = [[UILabel alloc]initWithFrame:CGRectMake(timeLable.left + 23 - 5 + 45, 20, 60, 20)];
    _today_outTime.text = @"9:20";
    _today_outTime.font = [UIFont systemFontOfSize:18];
    _today_outTime.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    [outView addSubview:_today_outTime];
    [_todayView addSubview:outView];
    height += 60;
    
    
    UIImageView *bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth, _todayView.height - height)];
    bottomImageView.image = [UIImage imageNamed:@"applicationforleave_bg"];
    [_todayView addSubview:bottomImageView];

}
//-----------统计---------------
#pragma makr ----创建头部的选择按钮
- (UIView *)createHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    //上层最外部的view
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    topView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:topView];
    //上层里面的view
    UIView *topInView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 200) / 2, 15, 200, 30)];
    [topView addSubview:topInView];
    UIImageView *topBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0, 150, 30)];
    topBgImageView.image = [UIImage imageNamed:@"yuanjiaojuxing"];
    [topInView addSubview:topBgImageView];
    
    //选择时间按钮
    UIButton *selectTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 10, 10, 10)];
    selectTimeButton.tag = 101;
    [selectTimeButton addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    [selectTimeButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [topInView addSubview:selectTimeButton];
    //点击时间变小
    UIButton *topLeftButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 6, 10, 17)];
    topLeftButton.tag = 102;
    [topLeftButton addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    [topLeftButton setImage:[UIImage imageNamed:@"leftarrow_date"] forState:UIControlStateNormal];
    [topInView addSubview:topLeftButton];
    //点击时间变大
    UIButton *topRightButton = [[UIButton alloc]initWithFrame:CGRectMake(205 - 10, 6, 10, 17)];
    topRightButton.tag = 103;
    [topRightButton addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    [topRightButton setImage:[UIImage imageNamed:@"rightarrow_date"] forState:UIControlStateNormal];
    [topInView addSubview:topRightButton];
    
    _count_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 130, 20)];
    _count_timeLabel.text = @"2016年9月25日";
    _count_timeLabel.font = [UIFont systemFontOfSize:16];
    _count_timeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
    [topInView addSubview:_count_timeLabel];
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
    countBgImageView.userInteractionEnabled = YES;
    countBgImageView.image = [UIImage imageNamed:@"statistics_border3"];
    [_countScrollerView addSubview:countBgImageView];
    
    UIImageView *zeroImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, (countBgImageView.width - 20) / 3 + 20, 50)];
    zeroImageView1.image = [UIImage imageNamed:@"statistics_border2"];
    UILabel *zerotimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, zeroImageView1.width, 20)];
    zerotimeLabel.text = @"日期";
    zerotimeLabel.textAlignment = NSTextAlignmentCenter;
    zerotimeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
    [zeroImageView1 addSubview:zerotimeLabel];
    [countBgImageView addSubview:zeroImageView1];
    
    UIImageView *zeroImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(zeroImageView1.right + 5, 5, (countBgImageView.width - 20) / 3 - 10, 50)];
    zeroImageView2.image = [UIImage imageNamed:@"statistics_border2"];
    [countBgImageView addSubview:zeroImageView2];
    UILabel *zeroGotimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, zeroImageView2.width, 20)];
    zeroGotimeLabel.text = @"到校";
    zeroGotimeLabel.textAlignment = NSTextAlignmentCenter;
    zeroGotimeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
    [zeroImageView2 addSubview:zeroGotimeLabel];
    
    UIImageView *zeroImageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(zeroImageView2.right + 5, 5, (countBgImageView.width - 20) / 3 - 10, 50)];
    zeroImageView3.image = [UIImage imageNamed:@"statistics_border2"];
    [countBgImageView addSubview:zeroImageView3];
    UILabel *zeroOuttimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, zeroImageView3.width, 20)];
    zeroOuttimeLabel.text = @"离校";
    zeroOuttimeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
    zeroOuttimeLabel.textAlignment = NSTextAlignmentCenter;
    [zeroImageView3 addSubview:zeroOuttimeLabel];
    //循环创建每一天的情况
    float height = 56;
    for (int i = 0; i < 30; i ++) {
        
        UIImageView *timeImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, height, (countBgImageView.width - 20) / 3 + 20, 50)];
        timeImageView1.image = [UIImage imageNamed:@"statistics_border2"];
        [countBgImageView addSubview:timeImageView1];
        UILabel *counttimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, timeImageView1.width, 20)];
        counttimeLabel.text = @"2016.99.12";
        counttimeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
        counttimeLabel.textAlignment = NSTextAlignmentCenter;
        [timeImageView1 addSubview:counttimeLabel];
        
        
        
        UIImageView *timeImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(timeImageView1.right + 5, height, (countBgImageView.width - 20) / 3 - 10, 50)];
        timeImageView2.image = [UIImage imageNamed:@"statistics_border2"];
        [countBgImageView addSubview:timeImageView2];
        UILabel *timeGotimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, timeImageView2.width, 20)];
        timeGotimeLabel.text = @"09:07";
        timeGotimeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
        timeGotimeLabel.textAlignment = NSTextAlignmentCenter;
        [timeImageView2 addSubview:timeGotimeLabel];
        
        UIImageView *timeImageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(timeImageView2.right + 5, height, (countBgImageView.width - 20) / 3 - 10, 50)];
        timeImageView3.image = [UIImage imageNamed:@"statistics_border2"];
        [countBgImageView addSubview:timeImageView3];
        UILabel *timeOuttimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, timeImageView3.width, 20)];
        timeOuttimeLabel.text = @"09:56";
        timeOuttimeLabel.textColor = [UIColor colorWithRed:0.431 green:0.435 blue:0.439 alpha:1];
        timeOuttimeLabel.textAlignment = NSTextAlignmentCenter;
        [timeImageView3 addSubview:timeOuttimeLabel];
        height += 53;
    }
    
    _count_height += height + 40;
    CGRect frame = countBgImageView.frame;
    frame.size.height = height + 3;
    countBgImageView.frame = frame;
}

- (void)btnAct:(UIButton *)sender{
    
    NSLog(@"123");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
