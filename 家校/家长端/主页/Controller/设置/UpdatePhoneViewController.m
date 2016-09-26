//
//  UpdatePhoneViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/26.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "UpdatePhoneViewController.h"
#import "UpdateOldPhoneViewController.h"
@interface UpdatePhoneViewController ()
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation UpdatePhoneViewController

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString *mobile = [accountDefaults objectForKey:@"mobile"];
    _phoneLabel.text = mobile;
}

- (IBAction)updateBtn:(UIButton *)sender {
    
    UpdateOldPhoneViewController *uopVC = [[UpdateOldPhoneViewController alloc]initWithNibName:@"UpdateOldPhoneViewController" bundle:nil];
    [self.navigationController pushViewController:uopVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString *mobile = [accountDefaults objectForKey:@"mobile"];
   _phoneLabel.text = mobile ;
    self.title = @"联系电话";
    backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    //重新定义返回按钮
    
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    _updateBtn.layer.masksToBounds = YES;
    _updateBtn.layer.cornerRadius = 5;
}
- (void)doBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
