//
//  NewsTableViewCell.m
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface NewsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLab;
@property (weak, nonatomic) IBOutlet UILabel *sourceLab;
@property (weak, nonatomic) IBOutlet UILabel *replyLab;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgsrcImageViews;

@end

@implementation NewsTableViewCell

-(void)setModel:(NewsModel *)model
{
    _model = model;
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.TitleLab.text = model.title;
    self.sourceLab.text = model.source;
    self.replyLab.text = [NSString stringWithFormat:@"%@",model.replyCount] ;
    
    for (int i = 0; i < model.imgextra.count; i++) {
        //取出控件
        UIImageView *img = self.imgsrcImageViews[i];
        
        NSDictionary *dic = model.imgextra[i];
        
        NSString *imgsrc = [dic objectForKey:@"imgsrc"];
       
        // 给控件赋值
        [img sd_setImageWithURL:[NSURL URLWithString:imgsrc]];
        
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
