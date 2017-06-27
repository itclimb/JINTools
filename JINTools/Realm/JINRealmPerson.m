//
//  JINRealmPerson.m
//  JINTools
//
//  Created by itclimb on 2017/6/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINRealmPerson.h"

@implementation JINRealmPerson

+ (instancetype)realmPersonWithDict:(NSDictionary *)dict{
    JINRealmPerson *person = [[self alloc] init];
    [person setValuesForKeysWithDictionary:dict];
    return person;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
