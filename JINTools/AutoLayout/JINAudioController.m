//
//  JINAudioController.m
//  JINTools
//
//  Created by itclimb on 2017/7/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINAudioController.h"
#import "JINAudioFileController.h"
#import <AVFoundation/AVFoundation.h>

@interface JINAudioController ()<AVAudioRecorderDelegate>

@property(nonatomic, strong) AVAudioRecorder *audioRecorder;

@property(nonatomic, weak) UIButton *button;

@property(nonatomic, strong) NSArray *audioFile;

@end

@implementation JINAudioController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //获取录制好的音频文件
    [self getDidAudioFile];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat button_w = 100;
    CGFloat button_h = button_w;
    CGFloat button_x = ([UIScreen mainScreen].bounds.size.width - button_w)/2;
    CGFloat button_y = ([UIScreen mainScreen].bounds.size.height - button_h)/2;
    button.frame = CGRectMake(button_x, button_y, button_w, button_h);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = button_w/2;
    button.layer.borderWidth = 5;
    button.layer.borderColor = [UIColor redColor].CGColor;
    [button setTitle:@"录制" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor brownColor];
    [button addTarget:self action:@selector(recoderClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.button = button;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"文件" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToDetailFile:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//MARK: - 录制事件
- (void)recoderClick:(UIButton *)sender{
    
    sender.selected =!sender.selected;
    if (sender.selected != YES) {
        [self.button setTitle:@"录制" forState:UIControlStateNormal];
        //[audioRecorder pause];暂停录制
        [_audioRecorder stop];//停止录制
    }else{
        
        [self.button setTitle:@"录制中..." forState:UIControlStateNormal];
        NSString *name = [NSString stringWithFormat:@"%d.aiff",(int)[NSDate date].timeIntervalSince1970];
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name];
        
        NSError *error;
        _audioRecorder = [[AVAudioRecorder alloc]initWithURL:[NSURL URLWithString:path]
                                                    settings:@{
                                                               AVNumberOfChannelsKey:@2,
                                                               AVSampleRateKey:@44100,
                                                               AVLinearPCMBitDepthKey:@32,
                                                               AVEncoderAudioQualityKey:@(AVAudioQualityMax),
                                                               AVEncoderBitRateKey:@128000
                                                               }
                                                       error:&error
                          ];
        _audioRecorder.delegate = self;
        //准备录制
        [_audioRecorder prepareToRecord];
        //录制
        [_audioRecorder record];
        //我们可以打印一下路径来查看我们录制结束之后的文件
        NSLog(@"开始录制:%@",path);
    }
}

- (void)jumpToDetailFile:(UIBarButtonItem *)item{
    JINAudioFileController *vc = [[JINAudioFileController alloc] init];
    vc.audioInfo = self.audioFile;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    [self getDidAudioFile];
}


/**
 获取已经录制好的音频文件
 */
- (void)getDidAudioFile{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //文件操作类
    NSFileManager *manager = [NSFileManager defaultManager];
    //获得当前文件的所有子文件subPathAtPath
    NSArray *pathList = [manager subpathsAtPath:path];
    
    //需要只获得录音文件
    NSMutableArray *audioPathList = [NSMutableArray array];
    for (NSString *audioPath in pathList) {
        if ([audioPath.pathExtension isEqualToString:@"aiff"]) {
            [audioPathList addObject:audioPath];
        }
    }
    NSLog(@"%@",audioPathList);
    self.audioFile = audioPathList.copy;
    
}


/**
 viewWillDisappear

 @param animated 动画
 */
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    _audioRecorder = nil;
    _audioRecorder.delegate = nil;
}

@end
