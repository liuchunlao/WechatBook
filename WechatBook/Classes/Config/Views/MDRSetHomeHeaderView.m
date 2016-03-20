//
//  MDRSetHomeHeaderView.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRSetHomeHeaderView.h"

@implementation MDRSetHomeHeaderView

+ (instancetype)homeHeaderView {

    return [[[NSBundle mainBundle] loadNibNamed:@"MDRSetHomeHeaderView" owner:nil options:nil] lastObject];
}

- (IBAction)iconBtnClick:(UIButton *)sender {

#warning 待完善！！！
    // 将自己的图片弹窗放大显示到屏幕上！
    MDRLog(@"将图片弹窗显示到屏幕上");
    
}

@end
