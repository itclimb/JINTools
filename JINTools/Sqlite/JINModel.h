//
//  JINModel.h
//  JINTools
//
//  Created by itclimb on 2017/6/22.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JINModel : NSObject

@property(nonatomic, assign) int no;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *age;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
