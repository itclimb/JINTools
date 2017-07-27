//
//  JINAudioFileController.h
//  JINTools
//
//  Created by itclimb on 2017/7/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JINAudioFileController : UIViewController

@property(nonatomic, strong) NSArray *audioInfo;

@end

typedef void(^PlayBlock)(BOOL selected);

@interface JINAudioFileCell : UITableViewCell

//音频文件名称
@property(nonatomic, strong) UILabel *title;
//播放 & 暂停
@property(nonatomic, strong) UIButton *playButton;


/**
 设置播放按钮Block

 @param block 按钮Block
 */
- (void)setPlayBlock:(PlayBlock)block;

@end
