//
//  MDRTool.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/27.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRTool.h"

@implementation MDRTool

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 80, 80);
    
    // 1.开启图片的图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    // 2.获取
    CGContextRef cxtRef = UIGraphicsGetCurrentContext();
    
    // 3.填充颜色
    CGContextSetFillColorWithColor(cxtRef, color.CGColor);
    
    CGContextFillRect(cxtRef, rect);
    
    // 4.获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.关闭图形上下文
    UIGraphicsEndImageContext();
    
    // 6.返回图片
    return img;
}

@end
