//
//  SaveRemarkView.m
//  FSCalendarExample
//
//  Created by admin on 2018/7/24.
//  Copyright © 2018年 wenchaoios. All rights reserved.
//

#import "SaveRemarkView.h"

@interface SaveRemarkView()
@property (strong, nonatomic) IBOutlet UIButton *ibSaveBut;

@end

@implementation SaveRemarkView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    _ibSaveBut.layer.cornerRadius = 10;
    _ibSaveBut.layer.masksToBounds = YES;
}

- (IBAction)ibSaveBut:(id)sender {
    
}
@end
