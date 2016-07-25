//
//  CycleCollectionViewCell.m
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CycleCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface CycleCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation CycleCollectionViewCell
-(void)setModel:(CycleModel *)model
{
    _model = model;
    //轮播图图片
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    //轮播图title
    self.titleLab.text = model.title;
}
@end







