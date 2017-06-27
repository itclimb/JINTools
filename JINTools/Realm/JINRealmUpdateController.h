//
//  JINRealmUpdateController.h
//  JINTools
//
//  Created by itclimb on 2017/6/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINBaseViewController.h"
#import "JINRealmPerson.h"

typedef void(^JINRealmUpdateBlock)(NSString *name,NSString *age, NSString *sex);

@interface JINRealmUpdateController : JINBaseViewController

@property(nonatomic, strong) JINRealmPerson *model;


/**
 给Block赋值
 @param block 更新Block
 */
- (void)setRealmUpdateBlock:(JINRealmUpdateBlock)block;

@end
