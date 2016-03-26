//
//  MDRTool.h
//  WechatBook
//
//  Created by 刘春牢 on 16/3/27.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDRTool : NSObject

#pragma mark - 根据颜色生成一张大小 为 80 * 80 的图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
