//
//  LXWaveView.m
//  LXWaveView
//
//  Created by chuanglong02 on 16/8/29.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#import "LXWaveView.h"

@interface LXWaveView()
@property(nonatomic,assign)CGFloat offsetx;//正弦曲线相位
@property(nonatomic,strong)CADisplayLink *waveDisplayLink;//定时器
@property(nonatomic,strong)CAShapeLayer *waveShapeLayer;
@end
@implementation LXWaveView
+(instancetype)addToView:(UIView *)view withFrame:(CGRect)frame
{
    LXWaveView *waveView =[[LXWaveView alloc]initWithFrame:frame];
    [view addSubview:waveView];
    return waveView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ([super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
-(void)setup
{
    _angularSpeed = 2.f;
    _waveSpeed = 9.f;
    _waveTime = 1.f;
    _waveColor =[UIColor whiteColor];
    
}
-(BOOL)wave
{
    if (self.waveShapeLayer.path) {
        return NO;
    }
    self.waveShapeLayer  =[CAShapeLayer layer];
    self.waveShapeLayer.fillColor = self.waveColor.CGColor;
    [self.layer addSublayer:self.waveShapeLayer];
    self.waveDisplayLink =[CADisplayLink displayLinkWithTarget:self selector:@selector(currentWave)];
     [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    if (self.waveTime > 0.f) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.waveTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stop];
        });
    }
    return YES;
}
-(void)currentWave
{
    self.offsetx -= self.waveSpeed;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, height/2);
    CGFloat y = 0.f;
    for (CGFloat x = 0.f; x < width; x++) {
        y =  height * sin(0.01 *(self.angularSpeed * x + self.offsetx));
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathCloseSubpath(path);
    self.waveShapeLayer.path = path;
    CGPathRelease(path);
}
-(void)stop
{
    [UIView animateWithDuration:1.f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.waveDisplayLink invalidate];
        self.waveShapeLayer.path = nil;
        self.waveDisplayLink = nil;
        self.alpha = 1.f;
    }];
}
@end
