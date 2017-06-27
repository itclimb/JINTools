//
//  JINDataTestController.h
//  JINTools
//
//  Created by itclimb on 2017/6/22.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JINDataTestController : UIViewController

@end

@interface JINDataTestCell : UITableViewCell
//显示key
@property(nonatomic, strong) UILabel *first;
//显示name
@property(nonatomic, strong) UILabel *title;
//显示年龄
@property(nonatomic, strong) UILabel *detail;

@end
