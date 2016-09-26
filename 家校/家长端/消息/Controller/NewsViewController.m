//
//  NewsViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/16.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UITableView *_tableView;
    UIImageView *_selectImageView;
    UILabel *_selectLabel;
    UITextField *_selectTextField;
    UIImageView *_leftImageView;

}
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *displayController;
@end

@implementation NewsViewController

- (instancetype)init{
    
    if (self = [super init]) {
        
        //设置控制器的 题目(导航栏) 标签图片(标签栏)
        self.title = @"消息";
        self.navigationController.view.backgroundColor = [UIColor whiteColor];
        self.tabBarItem.image = [UIImage imageNamed:@"news"];
        self.tabBarItem.title = @"消息";
    }
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight )];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _tableView.tableHeaderView = view;
    _tableView.tableFooterView = [[UIView alloc]init];
    //_tableView.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self createSelectTextFile];
    
    
}

#pragma mark ----顶部搜索框
- (void)createSelectTextFile{
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    self.searchBar.barStyle     = UIBarStyleDefault;
    self.searchBar.translucent  = YES;
    self.searchBar.delegate     = self;
    
    self.searchBar.placeholder  = @"搜索";
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTitle:@"取消"];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    
    [_tableView addSubview:self.searchBar];
    
    
    self.displayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.displayController.delegate                = self;
    self.displayController.searchResultsDataSource = self;
    self.displayController.searchResultsDelegate   = self;
    self.displayController.searchContentsController.edgesForExtendedLayout = UIRectEdgeNone;
    
}

#pragma mark ----textfiledDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:1 animations:^{
        _selectImageView.transform = CGAffineTransformTranslate(_selectImageView.transform, _selectTextField.left - _selectImageView.left + 7, 0);
        _selectLabel.transform = CGAffineTransformTranslate(_selectLabel.transform, _selectTextField.left + 30  - _selectLabel.left , 0);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
    });
    return YES;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location == 0 && range.length == 0) {
        _selectLabel.hidden = YES;
    }
    if (range.location == 0 && range.length == 1) {
        _selectLabel.hidden = NO;
    }
    
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    NSLog(@"将要清除文本时调用");
    return YES;
    
}



#pragma mark ----tableViewDatasouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"news_cell";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:self options:nil]lastObject];
    }
    
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"王大锤--英语老师";
        cell.timeLabel.text = @"昨天";
        cell.infoLabel.text = @"小明上课不听话";
    }
    if (indexPath.row == 1) {
        cell.nameLabel.text = @"大樱子--班主任";
        cell.timeLabel.text = @"昨天";
        cell.infoLabel.text = @"小明上课睡觉";
    }
    if (indexPath.row == 2) {
        cell.nameLabel.text = @"王小虎--数学老师";
        cell.timeLabel.text = @"8:20";
        cell.infoLabel.text = @"小明上课迟到了";
    }
    if (indexPath.row == 3) {
        cell.nameLabel.text = @"张老师--化学老师";
        cell.timeLabel.text = @"11:15";
        cell.infoLabel.text = @"小明在化学课上玩游戏小明在化学课上玩游戏小明在化学课上玩游戏小明在化学课上玩游戏";
    }
    if (indexPath.row == 4) {
        cell.nameLabel.text = @"王大锤--英语老师";
        cell.timeLabel.text = @"15:25";
        cell.infoLabel.text = @"小明逃课了小明逃课了小明逃课了";
    }
     cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

#pragma mark ----tableviewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
#pragma mark ----tableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.searchBar.top = _tableView.contentOffset.y;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
