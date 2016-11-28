//
//  AVPlayHorizontallyViewController.h
//  MPMoviePlayerController
//
//  Created by huishangsuo on 2016/11/26.
//  Copyright © 2016年 chuziming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVPlayHorizontallyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *avPlayerView;
@property (weak, nonatomic) IBOutlet UIButton *ReturnButton;
@property (nonatomic,strong) NSURL * string;
@property (nonatomic) float  time;
@end
