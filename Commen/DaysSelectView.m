//
//  DaysSelectView.m
//  DaysSelectDemo
//
//  Created by Ba by on 16/9/5.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "DaysSelectView.h"
#import "UIViewExt.h"
#import "DaysCollectionViewCell.h"
@interface DaysSelectView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIButton *_leftSelectDayBtn;//左侧时间选择按钮
    UIButton *_rightSelectDayBtn;//右侧时间选择按钮
    UILabel *_timeLabel;//时间按钮
    UILabel *_weekLable;//第几周
    NSMutableArray *_yearMonthWeekArr;//存放当前的年份月份和第几周
    
    
    NSMutableArray *_daysArr;
    UICollectionView *_collectionView;
    NSString *_nowYear;//当前年份
    NSString *_nowMonth;//当前月份
    NSString *_dayInfo;
    
     float _height;
}
//作用是 判断让前面已经过去的日期
@property (assign) NSInteger monthDays;

@property (assign ,nonatomic) NSInteger today;



@end
@implementation DaysSelectView
static NSString *identifier = @"collection_cell";
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createYearMonthDaysView];
        [self createWeekDaysView];
        [self createNowDayAndMonth];
        [self createCollectionViewLayout];
        [self createBtn];
    }
    return self;
}
#pragma mark ----顶部的日期选择
- (void)createYearMonthDaysView{
    
    UIView *topSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    topSelectView.backgroundColor = [UIColor colorWithRed:0 green:181 / 255.0 blue:242 / 255.0 alpha:1];
    //左侧的选择按钮
    _leftSelectDayBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 20, 20)];
    [_leftSelectDayBtn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    _leftSelectDayBtn.tag = 101;
    [_leftSelectDayBtn addTarget:self action:@selector(daysSelectAct:) forControlEvents:UIControlEventTouchUpInside];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(_leftSelectDayBtn.right + 15, 0, 1, topSelectView.height)];
    leftView.backgroundColor = [UIColor colorWithRed:0 green:169 /255.0 blue:227 / 255.0 alpha:1];
    [topSelectView addSubview:leftView];
    
    [topSelectView addSubview:_leftSelectDayBtn];
    //右侧的选择按钮
    _rightSelectDayBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 35, 10, 20, 20)];
    [_rightSelectDayBtn setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    _rightSelectDayBtn.tag = 102;
     [_rightSelectDayBtn addTarget:self action:@selector(daysSelectAct:) forControlEvents:UIControlEventTouchUpInside];
    [topSelectView addSubview:_rightSelectDayBtn];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(_rightSelectDayBtn.left - 15 , 0, 1, topSelectView.height)];
    rightView.backgroundColor = [UIColor colorWithRed:0 green:169 /255.0 blue:227 / 255.0 alpha:1];
    [topSelectView addSubview:rightView];
    //日期
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftView.right + 15, 10, 100, 20)];
    _timeLabel.text = @"2016年8月";
    _timeLabel.font = [UIFont systemFontOfSize:16];
    _timeLabel.textColor = [UIColor whiteColor];
    [topSelectView addSubview:_timeLabel];
    //当前第几周
    _weekLable = [[UILabel alloc]initWithFrame:CGRectMake(rightView.left - 48 - 15, 0, 48, topSelectView.height)];
    _weekLable.text = @"第5周";
    _weekLable.font = [UIFont systemFontOfSize:16];
    _weekLable.textColor = [UIColor whiteColor];
    [topSelectView addSubview:_weekLable];
    
    [self addSubview:topSelectView];
}

#pragma mark ----日期选择按钮的点击事件
- (void)daysSelectAct:(UIButton *)sender{
    _yearMonthWeekArr = [[NSMutableArray alloc]init];
    NSArray *arr1 = [_timeLabel.text componentsSeparatedByString:@"年"];//按“年”截取
    NSArray *arr2 = [arr1[1] componentsSeparatedByString:@"月"];
    //点击左侧的按钮 月份减少
    if(sender.tag == 101){
        if([arr2[0] integerValue] == 1){
            NSInteger year = [arr1[0] integerValue] - 1;
            [_yearMonthWeekArr addObject:[NSString stringWithFormat:@"%d",year]];
            [_yearMonthWeekArr addObject:@"12"];
            [_yearMonthWeekArr addObject:@"1"];
        }else{
            NSInteger month = [arr2[0] integerValue] - 1;
            [_yearMonthWeekArr addObject:arr1[0]];
            [_yearMonthWeekArr addObject:[NSString stringWithFormat:@"%d",month]];
            [_yearMonthWeekArr addObject:@"1"];
        }
    }
    
    
    if(sender.tag == 102){
        if([arr2[0] integerValue] == 12){
            NSInteger year = [arr1[0] integerValue] + 1;
            [_yearMonthWeekArr addObject:[NSString stringWithFormat:@"%d",year]];
            [_yearMonthWeekArr addObject:@"1"];
            [_yearMonthWeekArr addObject:@"1"];
        }else{
            NSInteger month = [arr2[0] integerValue] + 1;
            [_yearMonthWeekArr addObject:arr1[0]];
            [_yearMonthWeekArr addObject:[NSString stringWithFormat:@"%d",month]];
            [_yearMonthWeekArr addObject:@"1"];
        }
    }
    
    _timeLabel.text = [NSString stringWithFormat:@"%@年%@月",_yearMonthWeekArr[0],_yearMonthWeekArr[1]];
    _weekLable.text = [NSString stringWithFormat:@"第%@周",_yearMonthWeekArr[2]];
}

#pragma mark ----当月日期
- (void)createWeekDaysView{
    UIView *weekView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.width, 40)];
    weekView.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:234 / 255.0 blue:234 / 255.0 alpha:1];
    [self addSubview:weekView];
    
    NSArray *weekArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for(int i = 0 ; i < weekArr.count; i++){
        UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * self.width / 7, 10, self.width / 7, 20)];
        dayLabel.text = weekArr[i];
        dayLabel.font = [UIFont systemFontOfSize:16];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        [weekView addSubview:dayLabel];
    }
}

#pragma mark ----第一次加载的时候获取到的时间
- (void)createNowDayAndMonth{
    
    _daysArr = [[NSMutableArray alloc]init];
    NSString *monthFirstAndLastDay = [self getMonthBeginAndEndWith:[self dateBecameStringWithYearAndMonth:[NSDate date]]];
    
    NSMutableString *subFirstDay = [[NSMutableString alloc]initWithString:monthFirstAndLastDay];
    NSString *monthFirstDay = [subFirstDay substringToIndex:10];
    
    //判断当前月的第一天是星期几
    NSString *monthFirstDayWithWeek = [self weekStringFromDate:[self stringBecameDate:monthFirstDay]];
    
    //当前月份的天数
    self.monthDays = [self getNumberOfDaysOneYear:[NSDate date]];
    
    //获取到当前的年份和月份
    _nowMonth = [subFirstDay substringWithRange:NSMakeRange(5, 2)];
    _nowYear = [subFirstDay substringWithRange:NSMakeRange(0, 4)];
    
    //当前的年份月份和日期存储到一个数组当中去
    [_daysArr addObject:_nowYear];
    [_daysArr addObject:_nowMonth];
    
    //存贮当前月份的信息
    NSInteger number = 0;
    if (!([monthFirstDayWithWeek integerValue] == 7)) {
         number = _monthDays + [monthFirstDayWithWeek integerValue];
    }
    [_daysArr addObject:[NSString stringWithFormat:@"%d",number]];
    NSMutableArray *allDaysArr = [[NSMutableArray alloc]init];
    NSInteger today = 1;
    for (int i = 0; i < number; i++) {
        if (i < [monthFirstDayWithWeek integerValue] && [monthFirstDayWithWeek integerValue] != 7) {
            [allDaysArr addObject:@"0"];
        }else{
            if (today < 10) {
                [allDaysArr addObject:[NSString stringWithFormat:@"0%d",today]];
            }else{
                [allDaysArr addObject:[NSString stringWithFormat:@"%d",today]];
            }
            today ++;
        }
    }
    [_daysArr addObject:allDaysArr];
}

#pragma mark ----collectionView布局
- (void)createCollectionViewLayout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(self.frame.size.width / 7 , self.frame.size.width / 7 );
    
    layout.minimumInteritemSpacing = 0;
    
    layout.minimumLineSpacing = 0;
    float height = 0;
    if ([_daysArr[2] integerValue] % 7) {
        height = (1 + [_daysArr[2] integerValue] / 7) * self.frame.size.width / 7;
    }else{
        height = [_daysArr[2] integerValue] / 7 * self.frame.size.width / 7;
    }
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 80 , self.frame.size.width, height) collectionViewLayout:layout];
    
    _collectionView.dataSource = self;
    
    _collectionView.delegate = self;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[DaysCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self addSubview:_collectionView];
    _height = height + 80;
}

- (void)createBtn{
    UIButton *noBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _height, self.width / 2, 40)];
    [noBtn setTitle:@"取消" forState:UIControlStateNormal];
    [noBtn setBackgroundColor:[UIColor colorWithRed:0 green:181 / 255.0 blue:242 / 255.0 alpha:1]];
    [self addSubview:noBtn];
    [noBtn addTarget:self action:@selector(yesOrNoBtn:) forControlEvents:UIControlEventTouchUpInside];
    noBtn.tag = 100;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.width / 2, _height, 1, 40)];
    view.backgroundColor = [UIColor colorWithRed:3 / 255.0 green:169 / 255.0 blue:223 / 255.0 alpha:1];
    [self addSubview:view];
    UIButton *yesBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width / 2 + 1, _height, self.width / 2, 40)];
    [yesBtn addTarget:self action:@selector(yesOrNoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [yesBtn setTitle:@"确定" forState:UIControlStateNormal];
    [yesBtn setBackgroundColor:[UIColor colorWithRed:0 green:181 / 255.0 blue:242 / 255.0 alpha:1]];
    yesBtn.tag = 101;
    [self addSubview:yesBtn];
    
    _height += 40;
    CGRect frame = self.frame;
    frame.size.height = _height;
    self.frame = frame;
}

- (void)yesOrNoBtn:(UIButton *)sender{
    if (sender.tag == 100) {
        _block(@"0");
    }
    if (sender.tag == 101) {
        if (_dayInfo.length) {
            _block(_dayInfo);
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSString *number = _daysArr[2];
    return [number integerValue];
    
}

//单元格内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //使用注册的单元格类 创建单元格
    DaysCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    cell.day = [_daysArr[3] objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i < [_daysArr[2] integerValue]; i++) {
        NSIndexPath *indexPathConnect = [NSIndexPath indexPathForRow:i inSection:0];
        DaysCollectionViewCell *cell = (DaysCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPathConnect];
        cell.imageView.backgroundColor = [UIColor whiteColor];
    }
    _dayInfo = [[NSString alloc]init];
    DaysCollectionViewCell *cell = (DaysCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.imageView.backgroundColor = [UIColor redColor];
    
    NSString *string = [NSString stringWithFormat:@"%@年%@月%@日",_nowYear,_nowMonth,_daysArr[3][indexPath.row]];

    if ([_daysArr[3][indexPath.row] integerValue] != 0) {
        _dayInfo = string;
    }
}




//日期方法
#pragma mark -----获取某日是星期几
-(NSString *)weekStringFromDate:(NSDate *)date{
    
    NSArray *weeks=@[[NSNull null],@"7",@"1",@"2",@"3",@"4",@"5",@"6"];
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone=[[NSTimeZone alloc]initWithName:@"Asia/Beijing"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit=NSWeekdayCalendarUnit;
    NSDateComponents *components=[calendar components:calendarUnit fromDate:date];
    return [weeks objectAtIndex:components.weekday];
}

#pragma mark ---获取当月天数
- (NSInteger)getNumberOfDaysOneYear:(NSDate *)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    
    NSUInteger numberOfDaysInMonth = range.length;
    
    return numberOfDaysInMonth;
    
}

#pragma mark ---获取某个月的开始和结束日期
- (NSString *)getMonthBeginAndEndWith:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    NSString *s = [NSString stringWithFormat:@"%@-%@",beginString,endString];
    return s;
}

#pragma mark ---将date类型的时间转化成string类型的时间(年月日)
- (NSString *)dateBecameString:(NSDate *)date{
    
    NSDateFormatter *dateTostring = [[NSDateFormatter alloc]init];
    
    [dateTostring setDateFormat:@"yyyy-MM-dd"];
    
    NSString *stringDate = [dateTostring stringFromDate:date];
    
    return stringDate;
}

#pragma mark ---将date类型的时间转化成string类型的时间(年月日)
- (NSString *)dateBecameStringWithYearAndMonth:(NSDate *)date{
    
    NSDateFormatter *dateTostring = [[NSDateFormatter alloc]init];
    
    [dateTostring setDateFormat:@"yyyy-MM"];
    
    NSString *stringDate = [dateTostring stringFromDate:date];
    
    return stringDate;
}

#pragma mark ---将string类型的时间转化为date类型的时间
- (NSDate *)stringBecameDate:(NSString *)stringDate{
    
    NSDateFormatter *stringToDate = [[NSDateFormatter alloc]init];
    
    [stringToDate setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [stringToDate dateFromString:stringDate];
    
    
    return date;
}




@end
