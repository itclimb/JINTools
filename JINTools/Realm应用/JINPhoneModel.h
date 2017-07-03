//
//  JINPhoneModel.h
//  JINTools
//
//  Created by itclimb on 2017/6/30.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <Realm/Realm.h>

@interface JINPhoneModel : RLMObject

@property(nonatomic, copy) NSString *phoneID;
@property(nonatomic, copy) NSString *phoneName;
@property(nonatomic, copy) NSString *phoneSize;
@property(nonatomic, copy) NSString *phoneColor;

+ (instancetype)phoneModelWithDict:(NSDictionary *)dict;

@end
