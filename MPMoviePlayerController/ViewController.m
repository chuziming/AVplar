//
//  ViewController.m
//  MPMoviePlayerController
//
//  Created by huishangsuo on 2016/11/25.
//  Copyright © 2016年 chuziming. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "AVPlayViewController.h"
@interface ViewController ()
@property(nonatomic,strong)AVPlayer * player;
//@property(nonatomic,strong)AVPlayerViewController * playerView;
@property (nonatomic, strong) AVAudioSession *audioSession;

@property (weak, nonatomic)  UIView *viewAvPlayer;
//播放视图
//@property (weak, nonatomic) IBOutlet SMSliderBar *slider;
//进度条
@property (weak, nonatomic)  UIView *viewBottom;
//底部控制view
@property (weak, nonatomic)  UIButton *btnPause;
//暂停播放按钮
//下一个按钮
@property (weak, nonatomic)  UIButton *btnStart;

@property (weak, nonatomic)  UILabel *labelTimeNow;
//当前时间label
@property (weak, nonatomic)  UILabel *labelTimeTotal;
//总时间label
@property (strong, nonatomic) id timeObserver;
//视频播放时间观察者
@property (assign, nonatomic) float totalTime;
//视频总时长
@property (assign, nonatomic) BOOL isHasMovie;
//是否进行过移动
@property (assign, nonatomic) BOOL isBottomViewHide;
//底部的view是否隐藏
@property (assign, nonatomic) NSInteger subscript;
//数组下标，记录当前播放视频
@property (assign, nonatomic) NSInteger currentTime;
//当前视频播放时间位置
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(100, 420, 50, 50);
    button.backgroundColor =[UIColor blackColor];
        [button setTitle:@"跳转" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:button];
    NSLog(@"%@",self.view.subviews);
    
    }

-(void)buttonAction{
    AVPlayViewController * vc= [[AVPlayViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
