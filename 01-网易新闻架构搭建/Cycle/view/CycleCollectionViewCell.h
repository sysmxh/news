//
//  CycleCollectionViewCell.h
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleModel.h"

@interface CycleCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) CycleModel *model;
@end
