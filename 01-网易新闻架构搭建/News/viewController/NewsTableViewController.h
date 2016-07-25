//
//  NewsTableViewController.h
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController
//接收HomeCollectionViewCell传递过的数据
@property (nonatomic, copy) NSString *urlstr;
@end
