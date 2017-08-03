//
//  JINVideoController.m
//  JINTools
//
//  Created by itclimb on 2017/7/28.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINVideoController.h"
#import <AVFoundation/AVFoundation.h>

@interface JINVideoController ()

@property(nonatomic, strong) AVPlayer *player;

@end

@implementation JINVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //1.创建要播放的元素
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"1.mp4" withExtension:nil];
    //playerItemWithAsset:通过设备相册里面的内容创建一个要播放的对象,我们这里直接选择使用URL读取
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    /**
     * duration   当前播放元素的总时长
     * status  加载的状态  AVPlayerItemStatusUnknown,  未知状态
     * AVPlayerItemStatusReadyToPlay,  准备播放的状态
     * AVPlayerItemStatusFailed   失败的状态
     
     * 时间控制的类目
     * current
     * forwordPlaybackEndTime   跳到结束位置
     * reversePlaybackEndTime    跳到开始位置
     * seekToTime   跳到指定位置
     */
    
    //2.创建播放器
    _player = [AVPlayer playerWithPlayerItem:item];
    //也可以直接WithURL来获得一个地址的视频文件
    //    externalPlaybackVideoGravity    视频播放的样式
    //    AVLayerVideoGravityResizeAspect   普通的
    //    AVLayerVideoGravityResizeAspectFill   充满的
    //    currentItem  获得当前播放的视频元素
    
    //3.创建视频显示的图层
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    layer.frame = self.view.frame;
    // 显示播放视频的视图层要添加到self.view的视图层上面
    [self.view.layer addSublayer:layer];
    //start play
    [_player play];
}

@end
