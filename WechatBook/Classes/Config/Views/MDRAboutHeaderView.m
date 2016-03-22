//
//  MDRAboutHeaderView.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/22.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRAboutHeaderView.h"

@interface MDRAboutHeaderView ()

// 版本号
@property (nonatomic, weak) IBOutlet UILabel *versionLbl;

@end

@implementation MDRAboutHeaderView

+ (instancetype)aboutHeaderView {

    return [[[NSBundle mainBundle] loadNibNamed:@"MDRAboutHeaderView" owner:nil options:nil] lastObject];
    
}

- (void)awakeFromNib {
    
    self.versionLbl.textColor = [UIColor lightGrayColor];

    // 设置圆角及边线
    self.versionLbl.layer.cornerRadius = self.versionLbl.height * 0.5;
    
    self.versionLbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.versionLbl.layer.borderWidth = 1;
    
    // 获取版本号并设置
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    
    NSString *version = infoDict[@"CFBundleShortVersionString"];
    
    self.versionLbl.text = version;
    
}

@end
