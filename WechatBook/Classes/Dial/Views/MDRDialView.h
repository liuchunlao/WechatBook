//
//  MDRDialView.h
//  WechatBook
//
//  Created by 刘春牢 on 16/3/23.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DialNeedsHideNavBar)(BOOL);

@interface MDRDialView : UIView

@property (nonatomic, copy) DialNeedsHideNavBar hideNavBar;

@end
