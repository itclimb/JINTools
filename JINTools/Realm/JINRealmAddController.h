//
//  JINRealmAddController.h
//  JINTools
//
//  Created by itclimb on 2017/6/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINBaseViewController.h"

typedef void(^JINRealmAddBlock)(NSString *name, NSString *age, NSString *sex);

@interface JINRealmAddController : JINBaseViewController

- (void)setRealmAddBlock:(JINRealmAddBlock)block;

@end
