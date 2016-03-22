//
//  MDRSettingBaseCell.h
//  WechatBook
//
//  Created by 刘春牢 on 16/3/22.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MDRHeader               @"MDRHeader"
#define MDRFooter               @"MDRFooter"
#define MDRItems                @"MDRItems"


#define MDRIcon                 @"MDRIcon"
#define MDRTitle                @"MDRTitle"
#define MDRAccessoryType        @"MDRAccessoryType"
#define MDRAccessoryName        @"MDRAccessoryName"
#define MDRTargetVc             @"MDRTargetVc"
#define MDRPlistName            @"MDRPlistName"



@interface MDRSettingBaseCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

// cell的所有数据
@property (nonatomic, strong) NSDictionary *item;

@end
