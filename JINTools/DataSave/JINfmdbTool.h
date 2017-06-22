//
//  JINfmdbTool.h
//  JINTools
//
//  Created by itclimb on 2017/6/22.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JINModel.h"

@interface JINfmdbTool : NSObject
//增
+ (void)insert:(JINModel *)model;
//查
+ (NSArray *)queryWithKey:(NSString *)key;

@end
