//
//  DiyCollectionViewCell.m
//  XYCoverFlow
//
//  Created by 阳 on 16/8/22.
//  Copyright © 2016年 阳. All rights reserved.
//

#import "DiyCollectionViewCell.h"

@implementation DiyCollectionViewCell
static int i = 0;

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if(self = [super initWithFrame:frame])
    {
        self.lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, (ScreenWidth-40)/3, 120)];
        self.lab.numberOfLines = 0;
        i++;
        self.contentView.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_lab];
    }
    
    return self;
    
}
-(void)setNum:(int)num
{
    _num = num;
    [_lab setText:[NSString stringWithFormat:@"出现第%d个\n实际创建%d个",_num,i]];
}

-(void)setStr:(NSString *)str
{
    _str = str;
    [_lab setText:[NSString stringWithFormat:@"我是%@\n实际创建%d个",str,i]];
}

@end

