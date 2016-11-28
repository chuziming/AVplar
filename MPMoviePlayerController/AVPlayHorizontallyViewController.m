//
//  AVPlayHorizontallyViewController.m
//  MPMoviePlayerController
//
//  Created by huishangsuo on 2016/11/26.
//  Copyright © 2016年 chuziming. All rights reserved.
//

#import "AVPlayHorizontallyViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface AVPlayHorizontallyViewController ()
@property(nonatomic,strong)AVPlayer * player;
//@property(nonatomic,strong)AVPlayerViewController * playerView;
@property (nonatomic, strong) AVAudioSession *audioSession;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@end

@implementation AVPlayHorizontallyViewController
{
    NSDateFormatter *_dateFormatter;
    NSString *_totalTime;

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSURL *videoUrl = [NSURL URLWithString:@"http://w2.dwstatic.com/1/5/1525/127352-100-1434554639.mp4"];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:self.string options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    //创建播放器
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    // 将 AVPlayer 添加到 AVPlayerLayer 上
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.avPlayerView.frame;
    // 设置画面缩放模式
    // 等比例填充，直到一个维度到达区域边界

    [self.avPlayerView.layer addSublayer:playerLayer];
    [self.player play];
    
    [self.slider addTarget:self action:@selector(valueChange:) forControlEvents:(UIControlEventValueChanged)];

    
    

    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    
    
   
    [self.ReturnButton addTarget:self action:@selector(ReturnButtonAction) forControlEvents:(UIControlEventTouchUpInside)];

    
    UISwipeGestureRecognizer * pan =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.avPlayerView addGestureRecognizer:pan];
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    UISlider* volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeViewSlider = (UISlider*)view;
            break;
        }
    }
    
}

-(void)panAction:(UISwipeGestureRecognizer *)GestureRecognizer{
    switch (GestureRecognizer.direction) {
        case UISwipeGestureRecognizerDirectionUp:
            
            break;
        case UISwipeGestureRecognizerDirectionDown:
            
            break;
        default:
            break;
    }
    
}
 //支持旋转
 -(BOOL)shouldAutorotate{
return YES;
     }
 - (UIInterfaceOrientationMask)supportedInterfaceOrientations {
         return UIInterfaceOrientationMaskLandscapeLeft;
     }
 -(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
     
     
        return UIInterfaceOrientationLandscapeLeft;
     
   }
-(void)ReturnButtonAction{
    
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 
                             }];
}
-(void)valueChange:(UISlider * )slider{
    
 
    
    [self getDatazhidingkandaoneirong:slider.value];
  
    
}
-(void)getDatazhidingkandaoneirong:(float)data{
   
             CMTime  changedTime = CMTimeMakeWithSeconds(data, 1);

    
    
    __weak typeof(self) weakSelf = self;
    [self.player seekToTime:changedTime completionHandler:^(BOOL finished) {
        [weakSelf.player play];
    }];
}
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            CMTime duration = self.playerItem.duration;// 获取视频总长度
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
            _totalTime = [self convertTime:totalSecond];// 转换成播放时间·
            [self customVideoSlider:duration];// 自定义UISlider外观
            [self monitoringPlayback:playerItem];// 监听播放状态
            if (self.time) {
                [self getDatazhidingkandaoneirong:self.time];
            }
        
        
        
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        CMTime duration = _playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.progressView setProgress:timeInterval / totalDuration animated:YES];
        
    }
    
}
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}




//监控进度
- (void)timer
{
    self.slider.value = CMTimeGetSeconds(self.player.currentItem.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
}
-(void)btnPauseAction{
    [self.player pause];
    
    
}
- (void)customVideoSlider:(CMTime)duration {
    self.slider.maximumValue = CMTimeGetSeconds(duration);
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.slider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
}


-(void)startButtonAction{
    [self.player play];
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    //    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    //    dispatch_source_set_event_handler(timer, ^{
    //
    //        //倒计时结束，关闭
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [self timer];
    //        });
    //    });
    //    dispatch_resume(timer);
    //
    
    
}

- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    
    __weak typeof(self) weakSelf = self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        
        
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        [weakSelf.slider setValue:currentSecond animated:YES];
        NSString *timeString = [self convertTime:currentSecond];
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeString,_totalTime];
    }];
}
- (void)dealloc {
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    //    [self.playerView.player removeTimeObserver:self.playbackTimeObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
