//
//  HomeCollectionViewCell.m
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "NewsTableViewController.h"

@interface HomeCollectionViewCell ()
@property (nonatomic, strong)NewsTableViewController *newsVC;

@end

@implementation HomeCollectionViewCell
-(void)awakeFromNib
{
//    NSLog(@"%s",__func__);
//     self.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    self.newsVC = [Storyboard instantiateInitialViewController];
    self.newsVC.tableView.frame = self.contentView.bounds;
    self.newsVC.tableView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    [self addSubview:self.newsVC.tableView];
    
}
-(void)setUrlstr:(NSString *)urlstr
{
    _urlstr = urlstr;
    self.newsVC.urlstr = urlstr;
}

@end




