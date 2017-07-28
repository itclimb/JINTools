//
//  JINAudioFileController.m
//  JINTools
//
//  Created by itclimb on 2017/7/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//  [audioPlayer play];开始播放
//  [audioPlayer pause];暂停播放
//  [audioPlayer stop];停止播放，停止之后不能再次打开播放器，需要再次初始化才可以

#import "JINAudioFileController.h"
#import <AVFoundation/AVFoundation.h>

#define kCellHeight 60

@interface JINAudioFileController ()<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate>

@property(nonatomic, strong) AVAudioPlayer *audioPlayer;

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation JINAudioFileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)playWithAudioName:(NSString *)name andSelected:(BOOL)selected{
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name];
    
    NSError *error;
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:filePath] error:&error];
    _audioPlayer.delegate = self;
    // 设置播放次数,负数是无限循环,0是一次,1是2次
    _audioPlayer.numberOfLoops = -1;
    if (error) {
        NSLog(@"%@",error);
    }
    [_audioPlayer prepareToPlay];
    
    selected!=YES?[_audioPlayer pause]:[_audioPlayer play];
    
    _audioPlayer.enableRate = YES;
    _audioPlayer.rate = 1.5;
    
    //获得峰值 必须设置Metersenable为YES
    _audioPlayer.meteringEnabled = YES;
    //更新峰值
    [_audioPlayer updateMeters];
    //获得当前峰值
    NSLog(@"当前峰值%f",[_audioPlayer peakPowerForChannel:2]);
    NSLog(@"平均峰值%f",[_audioPlayer averagePowerForChannel:2]);
}


#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    
}
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    
}
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
    
}

//MARK: - lazy load
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kCellHeight;
        _tableView.separatorInset = UIEdgeInsetsZero;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.audioInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    JINAudioFileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[JINAudioFileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setPlayBlock:^(BOOL selected) {
        
        [self playWithAudioName:self.audioInfo[indexPath.row] andSelected:selected];

    }];
    cell.title.text = self.audioInfo[indexPath.row];
    return cell;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _audioPlayer = nil;
    _audioPlayer.delegate = self;
}

@end



@interface JINAudioFileCell ()

@property(nonatomic, copy) PlayBlock block;

@end

@implementation JINAudioFileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _title = [[UILabel alloc] init];
        CGFloat title_w = 200;
        CGFloat title_h = kCellHeight - 10;
        CGFloat title_x = 12;
        CGFloat title_y = 5;
        _title.frame = CGRectMake(title_x, title_y, title_w, title_h);
        [self.contentView addSubview:_title];
        
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat button_h = kCellHeight - 10;
        CGFloat button_w = button_h;
        CGFloat button_y = 5;
        CGFloat button_x = [UIScreen mainScreen].bounds.size.width - 12 - button_w;
        _playButton.frame = CGRectMake(button_x, button_y, button_w, button_h);
        _playButton.backgroundColor = [UIColor magentaColor];
        _playButton.layer.masksToBounds = YES;
        _playButton.layer.cornerRadius = button_w/2;
        _playButton.layer.borderWidth = 5;
        _playButton.layer.borderColor = [UIColor orangeColor].CGColor;
        [_playButton setTitle:@"play" forState:UIControlStateNormal];
        [self.contentView addSubview:_playButton];
        [_playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)playButtonClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (!sender.selected) {
        [_playButton setTitle:@"play" forState:UIControlStateNormal];
    }else{
        [_playButton setTitle:@"stop" forState:UIControlStateNormal];
    }
    if (self.block) {
        self.block(sender.selected);
    }
}

- (void)setPlayBlock:(PlayBlock)block{
    _block = block;
}

@end
