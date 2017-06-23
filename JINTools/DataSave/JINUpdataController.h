//
//  JINUpdataController.h
//  JINTools
//
//  Created by itclimb on 2017/6/23.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpdateBlock)(NSString *name, NSString *age);

@interface JINUpdataController : UIViewController

- (void)setUpdateBlock:(UpdateBlock)block;

@end
