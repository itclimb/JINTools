//
//  JINProperty.h
//  JINTools
//
//  Created by itclimb on 2017/6/21.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JINViewBackgroudColorType) {
    JINViewBackgroudColorTypeBlack,
    JINViewBackgroudColorTypeRed,
    JINViewBackgroudColorTypeBlue
};

@protocol JINProperty <NSObject>

@optional
@property(nonatomic, readonly) JINViewBackgroudColorType viewBackgroundColor;

@end
