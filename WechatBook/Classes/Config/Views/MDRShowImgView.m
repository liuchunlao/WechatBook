//
//  MDRShowImgView.m
//  WechatBook
//
//  Created by 刘春牢 on 16/4/28.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRShowImgView.h"

#define MDRApplication [UIApplication sharedApplication]


@implementation MDRShowImgView

// 原始的位置信息
static CGRect _oldRect;
// 遮盖 黑色的背景
static UIView *_coverView;
// 正在显示的图片框
static UIImageView *_showIngImgView;
#pragma mark - 显示图片框
+ (void)showImageView:(UIImageView *)imgView {

    // 1.图片
    UIImage *img = imgView.image;
    
    // 2.最初的位置
    _oldRect = imgView.frame;
    
    // MARK: - 遮盖
    UIView *coverV = [[UIView alloc] initWithFrame:MDRApplication.keyWindow.bounds];
    
    coverV.backgroundColor = [UIColor blackColor];
    coverV.alpha = 0.0;
    
    [MDRApplication.keyWindow addSubview:coverV];
    _coverView = coverV;
    
    
    // MARK: - 弹窗显示的图片框
    UIImageView *showImgView = [[UIImageView alloc] initWithImage:img];
    
    _oldRect = [imgView convertRect:imgView.bounds toView:MDRApplication.keyWindow];
    showImgView.frame = _oldRect;
    
    [coverV addSubview:showImgView];
    _showIngImgView = showImgView;
    
    
    // MARK: - 通过动画进行放大
    // 宽度/高度
    CGFloat width = MDRApplication.keyWindow.bounds.size.width;
    CGFloat height = width;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        coverV.alpha = 1.0;
        showImgView.bounds = CGRectMake(0, 0, width, height);
        showImgView.center = coverV.center;
        
    }];
    
    // MARK: - 添加点按手势，通过动画移除
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [coverV addGestureRecognizer:tap];
    
    // MARK: - 双击时进行图片放大
//    UITapGestureRecognizer *bigger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(biggerAction:)];
//    bigger.numberOfTapsRequired = 2;
//    [coverV addGestureRecognizer:bigger];
    
}

#pragma mark - 点按移除
// 缩回原来的位置移除
+ (void)tapAction:(UITapGestureRecognizer *)recognizer {
    
    // 缩小并移除
    [UIView animateWithDuration:0.25 animations:^{
        
        // 1.改回原始的frame
        _showIngImgView.frame = _oldRect;
        
        // 2.黑色背景透明
        _coverView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [_coverView removeFromSuperview];
        
    }];
    

}











@end
