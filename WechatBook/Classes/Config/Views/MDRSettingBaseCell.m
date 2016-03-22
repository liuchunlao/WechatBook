//
//  MDRSettingBaseCell.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/22.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRSettingBaseCell.h"

@implementation MDRSettingBaseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {

    static NSString *ID = @"cell";
    
    MDRSettingBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

#pragma mark - 设置数据
- (void)setItem:(NSDictionary *)item {
    
    // 1.设置图片
    if ([item[MDRIcon] length] > 0) {
        self.imageView.image = [UIImage imageNamed:item[MDRIcon]];
    }
    
    // 2.设置标题
    self.textLabel.text = item[MDRTitle];
    
    // 3.设置指示器
    // 3.1 获取字符串
    NSString *accessoryStr = item[MDRAccessoryType];
    // 3.2 转为OC的类
    if (accessoryStr.length == 0) {
        return;
    }
    Class className = NSClassFromString(accessoryStr);
    // 3.3 创建对象
    id obj = [[className alloc] init];
    
    // 4.判断
    if ([obj isKindOfClass:[UIImageView class]]) {
        
        UIImageView *imgView = (UIImageView *)obj;
        
        imgView.image = [UIImage imageNamed:item[MDRAccessoryName]];
        [imgView sizeToFit];
        
        self.accessoryView = imgView;
    }
    
    if ([obj isKindOfClass:[UISwitch class]]) {
        
        UISwitch *switcher = (UISwitch *)obj;
        
        // 如果是有开关，则这行cell没有选中效果，只能点击开关
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.accessoryView = switcher;
    }

}

@end
