//
//  MDRCalllogController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRCalllogController.h"
#import "MDRCoverView.h"


@interface MDRCalllogController ()

@end

@implementation MDRCalllogController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置标题
    self.navigationItem.title = @"通话记录";
    
    // 2.设置右侧"+"按钮
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addItemClick:)];
    self.navigationItem.rightBarButtonItem = addItem;
}

#pragma mark - 点击了"+"号按钮调用
- (void)addItemClick:(UIBarButtonItem *)item {
    
    // 1.弹出一个遮盖盖着整个屏幕只不过没有背景色
    // 2.在右侧有一个item
    
    // 遮盖
    // 1.创建遮盖视图
    MDRCoverView *cover = [[MDRCoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 1.2 设置方向，及要加载deplist文件
    cover.direction = kPopDirectionRight;
    cover.popListName = @"MDRAddPop1";
    
    // 1.3 赋值代码块
    cover.jumpBlock = ^(UIViewController *obj){
        
        // 执行跳转操作
        [self.navigationController pushViewController:obj animated:YES];
    
    };
    
    
    // 2.添加遮盖
    [self.tabBarController.view addSubview:cover];
    
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
