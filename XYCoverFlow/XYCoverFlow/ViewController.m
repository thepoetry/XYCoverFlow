//
//  ViewController.m
//  XYCoverFlow
//
//  Created by 阳 on 16/8/22.
//  Copyright © 2016年 阳. All rights reserved.
//
#import "ViewController.h"
#import "XYDiyLayout.h"
#import "DiyCollectionViewCell.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *loopView;
@property (nonatomic, strong) NSArray *names;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loopView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth -40, 200) collectionViewLayout:[XYDiyLayout new]];
    [self.view addSubview:_loopView];
    
    _loopView.showsVerticalScrollIndicator = NO;
    _loopView.showsHorizontalScrollIndicator = NO;
    _loopView.backgroundColor = [UIColor orangeColor];
    
    _loopView.dataSource = self;
    _loopView.delegate =  self;
    [_loopView registerClass:[DiyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    dispatch_async(dispatch_get_main_queue(), ^{
        _loopView.contentOffset = CGPointMake(2 * _loopView.bounds.size.width , 0);
    });
    
    _names = @[@"老王",@"老李",@"小王",@"2B",@"傻X",@"测试"];
    
}

#pragma mark -1.代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.names.count *300;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiyCollectionViewCell * cell = (DiyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //    cell.contentView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    //    cell.num = (int)indexPath.row;
    cell.str =self.names[indexPath.row % self.names.count];
    return cell;
}

#pragma mark -2.滚动代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x == 0)
    {
        scrollView.contentOffset = CGPointMake(2 * scrollView.bounds.size.width , 0);
        
    }
    if(scrollView.contentOffset.x == scrollView.contentSize.width - scrollView.bounds.size.width)
    {
        
        scrollView.contentOffset = CGPointMake(2 * scrollView.bounds.size.width , 0);
    }
}



@end
