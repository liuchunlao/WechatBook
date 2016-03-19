//
//  MDRContactListController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRContactListController.h"

@interface MDRContactListController ()

@property (nonatomic, weak) UIBarButtonItem *addContactItem;

@end

@implementation MDRContactListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.标题
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"免费", @"全部"]];
    
    segmentControl.width = 140;
    
    [segmentControl setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName : [UIColor whiteColor]
                                            } forState:UIControlStateSelected];
    
    [segmentControl setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName : MDRThemeColor
                                            } forState:UIControlStateNormal];
    
    segmentControl.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = segmentControl;
    
    [segmentControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    // 2.左侧按钮
    UIBarButtonItem *chooseItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(chooseItemClick:)];
    self.navigationItem.leftBarButtonItem = chooseItem;
    
    // 3.右侧按钮
    UIBarButtonItem *addContactItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_add_free_freinds"] style:UIBarButtonItemStylePlain target:self action:@selector(addContactItemClick)];
    self.navigationItem.rightBarButtonItem = addContactItem;
    
    self.addContactItem = addContactItem;
}

#pragma mark - 点击选择调用
/**
 通过代码直接修改barbuttonItem的文字或图片是可能会同时显示两个
 */
- (void)chooseItemClick:(UIBarButtonItem *)sender {

    if ([sender.title isEqualToString:@"选择"]) {

        sender.title = @"取消";
        self.addContactItem.title = @"全选";
        self.addContactItem.image = nil;
        
        
    } else {
    
        sender.title = @"选择";
        self.addContactItem.title = nil;
        self.addContactItem.image = [UIImage imageNamed:@"icon_add_free_freinds"];

        
    }

    
    
    
}

#pragma mark - 点击添加联系人
- (void)addContactItemClick {

    
    
    
}

#pragma mark - 刷新列表
- (void)segmentControlValueChanged:(UISegmentedControl *)segment {

    MDRLog(@"刷新联系人信息");
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
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
