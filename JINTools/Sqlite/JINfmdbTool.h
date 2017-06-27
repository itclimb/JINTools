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

/** add */
+ (void)insert:(JINModel *)model;
/** delete */
+ (void)deleteData:(JINModel *)model;
/** update */
+ (void)update:(JINModel *)model;
/** query */
+ (NSMutableArray *)queryWithKey:(NSString *)key;
/** queryAll */
+ (NSMutableArray *)queryAll;

@end
