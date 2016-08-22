//
//  XYDiyLayout.m
//  XYCoverFlow
//
//  Created by 阳 on 16/8/22.
//  Copyright © 2016年 阳. All rights reserved.
//

#import "XYDiyLayout.h"

@implementation XYDiyLayout

-(void)prepareLayout{
    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width/3, 150);
    
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}
/**
 *  对Cell 进行变形
 *
 *  @param rect 当前显示区域
 *
 *  @return 返回变形后的cell布局属性
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray * arrayAtts = [super layoutAttributesForElementsInRect:rect];
    CGFloat CenterX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    for(UICollectionViewLayoutAttributes * attr  in arrayAtts){
        CGFloat distance = ABS(attr.center.x - CenterX);
        CGFloat scale = self.collectionView.bounds.size.width / (self.collectionView.bounds.size.width + distance);
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return arrayAtts;
}
/**
 *  是否动态查询布局参数
 *
 *  @param newBounds 新的布局参数
 *
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
/**
 *  判定当前显示区域中的cell,并将其固定在中间部位
 *
 *  @param proposedContentOffset 当前CollectionView的ContentOffset
 *  @param velocity
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    ////}
    //-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
    //{
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5 ;
    //可视化区域:
    CGRect visibleRect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray * arrayAttrs = [self layoutAttributesForElementsInRect:visibleRect];
    
    //记录最中心的那个cell
    int min_idx = 0;
    UICollectionViewLayoutAttributes * minattr = arrayAttrs[min_idx];
    for (int i = 1; i < arrayAttrs.count; ++i) {
        CGFloat distance1 = ABS(minattr.center.x - centerX);
        UICollectionViewLayoutAttributes * curattr = arrayAttrs[i];
        CGFloat distance2 = ABS(curattr.center.x - centerX);
        if(distance2 < distance1)
        {
            minattr = curattr;
        }
    }
    UIImageView *i = [UIImageView new];
    
    CGFloat offsetX = minattr.center.x - centerX;
    
    return CGPointMake(proposedContentOffset.x + offsetX, proposedContentOffset.y);
}

@end