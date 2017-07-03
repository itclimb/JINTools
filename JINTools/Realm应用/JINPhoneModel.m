//
//  JINPhoneModel.m
//  JINTools
//
//  Created by itclimb on 2017/6/30.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINPhoneModel.h"

@implementation JINPhoneModel

+ (instancetype)phoneModelWithDict:(NSDictionary *)dict{
    JINPhoneModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (NSString *)primaryKey{
    return @"phoneID";
}

@end
