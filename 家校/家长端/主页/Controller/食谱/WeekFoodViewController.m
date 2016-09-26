//
//  WeekFoodViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/18.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "WeekFoodViewController.h"
#import "DaysSelectView.h"
@interface WeekFoodViewController ()
{
    UILabel *_weekFoodTimeLabel;//显示选择的时间
    float  _height;
    UILabel *_morningNameLabel;//早餐
    UILabel *_middayNameLabel;//午餐
    UILabel *_eveningNameLabel;//晚餐
    UILabel *_dessertNameLabel1;//早午点心
    UILabel *_dessertNameLabel2;//午晚点心
    NSArray *_infoArr;
}
@end

@implementation WeekFoodViewController

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"每周食谱";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *studentId = [accountDefaults objectForKey:@"studentInfo"];
    NSString *url = [NSString stringWithFormat:WeekFoodUrl,@"2016-08-23",[studentId objectForKey:@"schoolId"]];
    __weak WeekFoodViewController *weakSelf = self;
    [AFNetManager postRequestWithURL:url withParameters:nil success:^(id response) {
        _infoArr = [response objectForKey:@"results"];
        if (_infoArr) {
            __strong WeekFoodViewController *strongSelf = weakSelf;
            [strongSelf reloadDataWithIndex:101];
        }
        
    }];
    
    [self createTopTimeView];
    [self createWeakButton];
    [self createWeekRecipe];
    [self createBottomImageView];
    // Do any additional setup after loading the view from its nib.
}


- (void)reloadDataWithIndex:(NSInteger)index{
    NSLog(@"%@",_infoArr);
    for(int i=0;i<_infoArr.count;i++){
        NSDictionary *info =  _infoArr[i];
        NSString *content = [info objectForKey:@"content"];
        NSArray *arr =  [content componentsSeparatedByString:NSLocalizedString(@"|", nil)];
        if ([[info objectForKey:@"week"] isEqualToString:@"星期一"] && index == 101) {
            _morningNameLabel.text = arr[0];
            _dessertNameLabel1.text = arr[1];
            _middayNameLabel.text = arr[2];
            _dessertNameLabel2.text = arr[3];
            _eveningNameLabel.text = arr[4];
        }
        if ([[info objectForKey:@"week"] isEqualToString:@"星期二"] && index == 102) {
            _morningNameLabel.text = arr[0];
            _dessertNameLabel1.text = arr[1];
            _middayNameLabel.text = arr[2];
            _dessertNameLabel2.text = arr[3];
            _eveningNameLabel.text = arr[4];
        }
        if ([[info objectForKey:@"week"] isEqualToString:@"星期三"] && index == 103) {
            _morningNameLabel.text = arr[0];
            _dessertNameLabel1.text = arr[1];
            _middayNameLabel.text = arr[2];
            _dessertNameLabel2.text = arr[3];
            _eveningNameLabel.text = arr[4];
        }
        if ([[info objectForKey:@"week"] isEqualToString:@"星期四"] && index == 104) {
            _morningNameLabel.text = arr[0];
            _dessertNameLabel1.text = arr[1];
            _middayNameLabel.text = arr[2];
            _dessertNameLabel2.text = arr[3];
            _eveningNameLabel.text = arr[4];
        }
        if ([[info objectForKey:@"week"] isEqualToString:@"星期五"] && index == 105) {
            _morningNameLabel.text = arr[0];
            _dessertNameLabel1.text = arr[1];
            _middayNameLabel.text = arr[2];
            _dessertNameLabel2.text = arr[3];
            _eveningNameLabel.text = arr[4];
        }
    }
    
    

}

#pragma mark ----上层显示时间的view
- (void)createTopTimeView{
    _height = 64;
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, 60)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.userInteractionEnabled = YES;
    UIImageView *topBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 180) / 2, 15, 180, 30)];
    topBgImageView.image = [UIImage imageNamed:@"yuanjiaojuxing"];
    topBgImageView.userInteractionEnabled = YES;
    [topView addSubview:topBgImageView];
    [self.view addSubview:topView];
    //选择时间的按钮
    UIButton *selectTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(150, 5, 30, 30)];
    [selectTimeButton addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 10, 10)];
    image.image = [UIImage imageNamed:@"down"];
    image.userInteractionEnabled = YES;
    [selectTimeButton addSubview:image];
    //[selectTimeButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [topBgImageView addSubview:selectTimeButton];
    //显示时间的label
    _weekFoodTimeLabel= [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 140, 20)];
    _weekFoodTimeLabel.text = @"2016年9月1日";
    _weekFoodTimeLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [topBgImageView addSubview:_weekFoodTimeLabel];
    _height += 61;
    [self drowViewWithheight:_height];
}

#pragma mark ----创建星期一到星期五的button
- (void)createWeakButton{
    _height += 10;
    for (int i = 0; i < 5; i ++) {
        NSArray *weekArr = @[@"周一",@"周二",@"周三",@"周四",@"周五"];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(30 + i * (5 + (kScreenWidth - 80) / 5), _height, (kScreenWidth - 80) / 5, 30)];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setBackgroundImage:[UIImage imageNamed:@"weekdietnocheck"] forState:UIControlStateNormal];
        button.tag = 101 + i;
        [button addTarget:self action:@selector(weekDaysBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"weekdietnocheck"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forState:UIControlStateNormal];
        [button setTitle:weekArr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:button];
        if (i == 0) {
            [button setBackgroundImage:[UIImage imageNamed:@"weekdietchecked"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"weekdietchecked"] forState:UIControlStateHighlighted];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    _height += 20;
}
#pragma mark ----创建食谱
- (void)createWeekRecipe{
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, _height + 10, kScreenWidth - 40, 310 * ScaleHeight)];
    bgImageView.image = [UIImage imageNamed:@"statistics_border3"];
    [self.view addSubview:bgImageView];
    float height = 3;
    
    for (int i = 0; i < 5; i++) {
        NSArray *recipeNameArr = @[@"早餐",@"点心",@"午餐",@"点心",@"晚餐"];
        UIImageView *leftRecipeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(3, height, (kScreenWidth - 20 - 9) / 3, 70 * ScaleHeight)];
        leftRecipeImageView.image = [UIImage imageNamed:@"statistics_border2"];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 70 * ScaleHeight / 2 - 6, leftRecipeImageView.width, 20)];
        titleLabel.text = recipeNameArr[i];
        titleLabel.font = [UIFont fontWithName:@"font" size:14];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithRed:0.509 green:0.509 blue:0.509 alpha:1];
        [leftRecipeImageView addSubview:titleLabel];
        
        UIImageView *rightRecipeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8 + (kScreenWidth - 40 - 15) / 3, height, (kScreenWidth - 40 - 9) / 3 * 2, 70 * ScaleHeight)];
        rightRecipeImageView.image = [UIImage imageNamed:@"statistics_border"];
        UILabel *recipeLabel = [[UILabel alloc]init];
        if (i == 0) {
            _morningNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70 * ScaleHeight  / 2 - 6, rightRecipeImageView.width - 40, 20)];
            recipeLabel = _morningNameLabel;
        }
        if (i == 1) {
            _dessertNameLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 70 * ScaleHeight  / 2 - 6, rightRecipeImageView.width - 40, 20)];
            recipeLabel = _dessertNameLabel1;
        }
        if (i == 2) {
            _middayNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70 * ScaleHeight  / 2 - 6, rightRecipeImageView.width - 40, 20)];
            recipeLabel = _middayNameLabel;
        }
        if (i == 3) {
            _dessertNameLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 70 * ScaleHeight  / 2 - 6, rightRecipeImageView.width - 40, 20)];
            recipeLabel = _dessertNameLabel2;
        }
        if (i == 4) {
            _eveningNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70 * ScaleHeight  / 2 - 6, rightRecipeImageView.width - 40, 20)];
            recipeLabel = _eveningNameLabel;
        }
        
        recipeLabel.font = [UIFont systemFontOfSize:14];
        recipeLabel.numberOfLines = 2;
        recipeLabel.text = recipeNameArr[i];
        recipeLabel.textColor = [UIColor colorWithRed:0.509 green:0.509 blue:0.509 alpha:1];
        recipeLabel.textAlignment = NSTextAlignmentCenter;
        [rightRecipeImageView addSubview:recipeLabel];
        
        NSString *text = @"鸡蛋，牛奶，牛奶，牛奶，牛奶";
        GetTextHeightLabel *getHeightLabel = [[GetTextHeightLabel alloc]initWithFrame:recipeLabel.frame WithText1:text];
        NSMutableAttributedString *attString = [getHeightLabel backAttString];
        recipeLabel.attributedText = attString;
        if (getHeightLabel.height > 20) {
            CGRect frame = recipeLabel.frame;
            frame.origin.y = frame.origin.y - 8;
            frame.size.height = getHeightLabel.height;
            recipeLabel.frame = frame;
        }
        
        [bgImageView addSubview:leftRecipeImageView];
        [bgImageView addSubview:rightRecipeImageView];
        height += 70 * ScaleHeight;
    }
    CGRect frame = bgImageView.frame;
    frame.size.height = height;
    bgImageView.frame = frame;
    
    _height += 355 * ScaleHeight;
}
#pragma mark ----创建底部的图片
- (void)createBottomImageView{
    _height += 10;
    UIImageView *bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _height , kScreenWidth, kScreenHeight - _height)];
    bottomImageView.image = [UIImage imageNamed:@"recipeBottomImage"];
    [self.view addSubview:bottomImageView];
}

#pragma mark ----选择星期几
- (void)weekDaysBtnAct:(UIButton *)sender{
    
    for (int i = 0; i < 5; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:101+i];
        [button setBackgroundImage:[UIImage imageNamed:@"weekdietnocheck"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"weekdietnocheck"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forState:UIControlStateNormal];
    }
    [sender setBackgroundImage:[UIImage imageNamed:@"weekdietchecked"] forState:UIControlStateNormal];
    [sender setBackgroundImage:[UIImage imageNamed:@"weekdietnocheck"] forState:UIControlStateHighlighted];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self reloadDataWithIndex:sender.tag];
    
}

#pragma mark ----绘制一条横线
- (void)drowViewWithheight:(float)height{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, height, kScreenWidth, 2)];
    view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] ;
    [self.view addSubview:view];
}


#pragma mark ----选择时间的按钮
- (void)btnAct:(UIButton *)sender{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:view];
    
    DaysSelectView *dayView = [[DaysSelectView alloc]initWithFrame:CGRectMake(10, 64 + (kScreenHeight - 64 - 500) / 2, kScreenWidth - 20, 500)];
    [dayView setBlock:^(NSString *dayString) {
        if (![dayString isEqualToString:@"0"]) {
             _weekFoodTimeLabel.text = dayString;
        }
       
        [view removeFromSuperview];
    }];
    [view addSubview:dayView];
    
    [self.view addSubview:view];
}
#pragma mark ----返回按钮
- (void)doBack:(UIButton *)sender{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
