//
//  LXWaveView.h
//  LXWaveView
//
//  Created by chuanglong02 on 16/8/29.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXWaveView : UIView
@property(nonatomic,assign)CGFloat angularSpeed;//角速度
@property(nonatomic,assign)CGFloat waveSpeed;//波动的速du
@property(nonatomic,assign)NSTimeInterval waveTime;
@property(nonatomic,strong)UIColor *waveColor;
+(instancetype)addToView:(UIView *)view withFrame:(CGRect)frame;
-(BOOL)wave;//是否波动
-(void)stop;//波动停止
@end
