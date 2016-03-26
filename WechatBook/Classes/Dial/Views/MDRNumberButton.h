//
//  MDRNumberButton.h
//  WechatBook
//
//  Created by 刘春牢 on 16/3/24.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//  拨号按钮

#import <UIKit/UIKit.h>

typedef enum {

    kNumberButtonTypeNumber,    // 号码
    kNumberButtonTypeMi,        // * 键
    kNumberButtonTypeJing,      // # 键
    kNumberButtonTypeAdd,       // 加号键
    kNumberButtonTypeDelete,    // 删除键
    kNumberButtonTypePhoneCall  // 拨号键


} kNumberButtonType;

@interface MDRNumberButton : UIButton

@property (nonatomic, strong) NSDictionary *item;

/** 按键类型 */
@property (nonatomic, assign) kNumberButtonType type;

@end
