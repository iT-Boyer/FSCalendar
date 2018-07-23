//
//  CheckSelfViewController.m
//  FSCalendarExample
//
//  Created by admin on 2018/7/18.
//  Copyright © 2018年 wenchaoios. All rights reserved.
//

#import "CheckSelfViewController.h"
#import "IBInspectableView.h"
#import "BaseInfoModel.h"

@interface CheckSelfViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *ibuserImageView;
@property (strong, nonatomic) IBOutlet UILabel *ibUsernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibCheckDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibAdrressLabel;

@property (strong, nonatomic) IBOutlet UILabel *ibStoreNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ibCheckNumLabel;
@property (strong, nonatomic) IBOutlet UIButton *ibNextStepButton;
@property (strong, nonatomic) IBOutlet UILabel *ibCheckTypeLabel;
@property (strong, nonatomic) IBOutlet IBInspectableView *ibUserInfoView;
@property (strong, nonatomic) BaseInfoModel *infoModel;
@end

@implementation CheckSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ibNextStepButton.layer.cornerRadius = 10;
    _ibNextStepButton.layer.masksToBounds = YES;
    _ibuserImageView.layer.cornerRadius = _ibuserImageView.frame.size.width/2;
    _ibuserImageView.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarType:YES];
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)viewDidAppear:(BOOL)animated
{
    [_ibUserInfoView drawBorderPath];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setNavigationBarType:NO];
    //归档
    [self.infoModel arhive];
}
-(void)setNavigationBarType:(BOOL)isClear
{
    self.navigationController.navigationBar.translucent = YES;
    UIColor *color = isClear?[UIColor clearColor]:[UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = isClear;
}

#pragma mark UI数据
-(void)setupBaseInfoData
{
    //TODO: 头像
//    NSDictionary *did = [LoginAndRegister currentUserMessage];
//    _userHeadurl = [did objectForKey:@"userHeadurl"];
//    [_ibuserImageView setImageFromUrl:_userModel.userHeadurl];

    //人员实名
    //    NSDictionary *employeeInfo = [LoginAndRegister currentUserEmployeeInfo];
//    NSString *employeeName = [employeeInfo objectForKey:@"Name"];
//    if (![employeeName isEqualToString:@""]
//        && employeeName != nil
//        && ![employeeName isKindOfClass:[NSNull class]]) {
//    _ibUsernameLabel.text = employeeName;
//    }

    _ibStoreNameLabel.text = @"";
    _ibCheckTypeLabel.text = @"";
    _ibCheckNumLabel.text = [NSString stringWithFormat:@"本年度第%d次检查",5];
    //TODO: 地址
    
    //当前日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd  hh:mm";
    _ibCheckDateLabel.text = [dateFormatter stringFromDate:[NSDate new]];
    self.infoModel.StoreName = _ibStoreNameLabel.text;
    self.infoModel.InspectTypeName = _ibCheckTypeLabel.text;
    self.infoModel.YearTimes  = _ibCheckNumLabel.text;
    self.infoModel.InspectDate = _ibCheckDateLabel.text;
    self.infoModel.InspectTypeName = @"";
}
#pragma mark UI事件
- (IBAction)ibaBackBarAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ibaCheckTypeListAction:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self addActionTo:alertController from:@[@"检查报告",@"全项检查",@"常规检查"]];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)addActionTo:(UIAlertController *)alertVC from:(NSArray *)titleArr
{
    for (NSString *title in titleArr) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _ibCheckTypeLabel.text = @"选定检查";
        }];
        [action setValue:[UIColor darkGrayColor] forKey:@"titleTextColor"];
        [alertVC addAction:action];
    }
}
- (IBAction)ibaNextStepAction:(id)sender {
    
}

#pragma mark setter/getter
-(BaseInfoModel *)infoModel
{
    //归档
    if (!_infoModel) {
        //解档
        
        if (!_infoModel){
            _infoModel = [BaseInfoModel unArhive:[BaseInfoModel class]];
            if (_infoModel) return _infoModel;
            _infoModel = [BaseInfoModel new];
        }
    }
    return _infoModel;
}

@end
