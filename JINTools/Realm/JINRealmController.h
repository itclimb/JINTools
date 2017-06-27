//
//  JINRealmController.h
//  JINTools
//
//  Created by itclimb on 2017/6/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JINBaseViewController.h"

@interface JINRealmController :JINBaseViewController

@end

@interface JINRealmCell : UITableViewCell

@property(nonatomic, strong) UIImageView *icon;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *ageLabel;
@property(nonatomic, strong) UILabel *sexLabel;

@end
