//
//  ViewController.m
//  LXWaveView
//
//  Created by chuanglong02 on 16/8/29.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import "LXWaveView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tablview;
@property(nonatomic,strong)LXWaveView *waveView;
//@property(nonatomic,strong)WXWaveView *waveView;
@end

@implementation ViewController

{
    int i ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tablview];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 245)];
    headerView.backgroundColor = [UIColor colorWithRed:164/255.f green:174/255.f blue:246/255.f alpha:1];
    self.tablview.tableHeaderView = headerView;
    i = 1;
    
    UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(20, 70, 100, 100)];
    imageview.image =[UIImage imageNamed:@"IMG_1908.jpg"];
    [self.tablview.tableHeaderView addSubview: imageview];
    imageview.layer.cornerRadius = 50;
    imageview.layer.masksToBounds = YES;
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imageview.frame) +5, 100, 21)];
    label.text = @"宝贝，Ly";
    label.textAlignment = NSTextAlignmentCenter;
    [self.tablview.tableHeaderView addSubview:label];
    
}
-(void)viewDidLayoutSubviews
{
    if (!self.waveView) {
         self.waveView = [LXWaveView addToView:self.tablview.tableHeaderView withFrame:CGRectMake(0, CGRectGetHeight(self.tablview.tableHeaderView.frame) -5, CGRectGetWidth(self.tablview.frame), 5)];
//        self.waveView.backgroundColor =[UIColor orangeColor];
//         Optional Setting
//                self.waveView.waveTime = 0.f;     // When 0, the wave will never stop;
                self.waveView.waveColor = [UIColor groupTableViewBackgroundColor];
//                self.waveView.waveSpeed = 25.f;
//                self.waveView.angularSpeed = 1.8f;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self.waveView wave]) {
        
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 0) {
        
        self.navigationController.navigationBar.alpha = 1 - MIN(scrollView.contentOffset.y, 64)/64.0;
    }else{
        self.navigationController.navigationBar.alpha = 1;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20 ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) ] ;
    if (!cell) {
        cell = [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@"只你"];
    return cell;
    
}


- (UITableView *)tablview {
	if(_tablview == nil) {
		_tablview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
        _tablview.delegate = self;
        _tablview.dataSource = self;
        _tablview.showsHorizontalScrollIndicator = NO;
        _tablview.showsVerticalScrollIndicator= YES;
	}
	return _tablview;
}

@end
