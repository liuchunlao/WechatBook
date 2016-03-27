//
//  MDRNumberView.h
//  WechatBook
//
//  Created by 刘春牢 on 16/3/24.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDRNumberView;
@protocol MDRNumberViewDelegate <NSObject>

@optional
- (void)numberView:(MDRNumberView *)numberView wantToCallNumber:(NSString *)numberStr;

@end


@interface MDRNumberView : UIView

- (CGFloat)numberHeight;

@property (nonatomic, weak) id<MDRNumberViewDelegate> delegate;


@end
