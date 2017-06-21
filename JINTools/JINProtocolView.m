//
//  JINProtocolView.m
//  JINTools
//
//  Created by itclimb on 2017/6/21.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINProtocolView.h"

@implementation JINProtocolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        if ([self respondsToSelector:@selector(viewBackgroundColor)]) {
            switch (self.viewBackgroundColor) {
                case JINViewBackgroudColorTypeBlack:
                    self.backgroundColor = [UIColor blackColor];
                    break;
                case JINViewBackgroudColorTypeBlue:
                    self.backgroundColor = [UIColor blueColor];
                    break;
                case JINViewBackgroudColorTypeRed:
                    self.backgroundColor = [UIColor redColor];
                    break;
                default:
                    break;
            }
        }
    }
    return self;
}

@end
