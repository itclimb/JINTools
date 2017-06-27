//
//  JINBlockSecondController.h
//  JINTools
//
//  Created by itclimb on 12/06/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JINSecondBlock)(NSString *content);

@interface JINBlockSecondController : UIViewController

- (void)setSecondBlock:(JINSecondBlock)block;

@end
