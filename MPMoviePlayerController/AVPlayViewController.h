//
//  AVPlayViewController.h
//  MPMoviePlayerController
//
//  Created by huishangsuo on 2016/11/25.
//  Copyright © 2016年 chuziming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVPlayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *aVplayerView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIProgressView *videoProgressView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *quanPingButton;

@end
