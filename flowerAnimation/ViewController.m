//
//  ViewController.m
//  flowerAnimation
//
//  Created by L_晨曦 on 2017/9/23.
//  Copyright © 2017年 L_晨曦. All rights reserved.
//

#import "ViewController.h"


static CGFloat const flowerWH = 66.0f/2;
static CGFloat const totalTime = 80.0f;
@interface ViewController ()

@property (nonatomic, strong) UIView * img;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) CAShapeLayer* shapeLayer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImageView *bgFlowerView;
@property (nonatomic, assign) CGFloat isTime;
@property (nonatomic, strong) UIButton *flowerButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.flowerButton];
    _isTime = 0;
    
}

-(void)flowerBtnAction{
    _flowerButton.userInteractionEnabled = NO;
    [_flowerButton setImage:[UIImage imageNamed:@"live_sendflower_dark"] forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerCalculate) userInfo:nil repeats:YES];
    //[self timerCalculate];
}

-(void)timerCalculate {
    if (self.shapeLayer.strokeEnd >= 1.0f) {
        [_bgFlowerView removeFromSuperview];
        _shapeLayer = nil;
        _flowerButton.userInteractionEnabled = YES;
        [_flowerButton setImage:[UIImage imageNamed:@"live_sendflower"] forState:UIControlStateNormal];
        [_timer invalidate];
        _timer = nil;
    }else{
        // 开始赋值
        if (_isTime != 0 ) {
            _shapeLayer.strokeEnd = _isTime;
            _isTime = 0;
        }
        self.shapeLayer.strokeEnd += 1/totalTime;
    }
}

#pragma mark - lazy

- (CAShapeLayer *)shapeLayer {
    if (_shapeLayer == nil) {
        UIBezierPath *path =[UIBezierPath bezierPathWithArcCenter:CGPointMake(flowerWH/2, flowerWH/2) radius:flowerWH startAngle:-M_PI/2 endAngle:M_PI *3 / 2 clockwise:YES];
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.strokeStart = 0;
        _shapeLayer.strokeEnd = 0;
        _shapeLayer.path = path.CGPath;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor =  [UIColor blueColor].CGColor;
        _shapeLayer.lineWidth = flowerWH *2;
        
        _bgFlowerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, flowerWH, flowerWH)];
        _bgFlowerView.image = [UIImage imageNamed:@"live_sendflower"];
        _bgFlowerView.layer.contentsGravity = kCAGravityCenter;
        _bgFlowerView.layer.mask = _shapeLayer;
        [self.flowerButton addSubview:_bgFlowerView];
    }
    return _shapeLayer;
}

- (UIButton *)flowerButton {
    if (_flowerButton == nil) {
        _flowerButton = [[UIButton alloc] init];
        _flowerButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _flowerButton.adjustsImageWhenHighlighted = NO;
        _flowerButton.frame = CGRectMake(0, 0, flowerWH, flowerWH);
        _flowerButton.center = self.view.center;
        [_flowerButton setImage:[UIImage imageNamed:@"live_sendflower"] forState:UIControlStateNormal];
        [_flowerButton addTarget:self action:@selector(flowerBtnAction) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:_flowerButton];
    }
    return _flowerButton;
    
}


@end
