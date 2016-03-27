//
//  MDRDialView.h
//  WechatBook
//
//  Created by 刘春牢 on 16/3/23.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DialNeedsHideNavBar)(BOOL);

typedef void(^DialWantAddContact)(NSString *);

@interface MDRDialView : UIView

// 隐藏导航栏
@property (nonatomic, copy) DialNeedsHideNavBar hideNavBar;

// 添加联系人
@property (nonatomic, copy) DialWantAddContact addContact;

@end
