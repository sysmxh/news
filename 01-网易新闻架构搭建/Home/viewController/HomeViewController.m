//
//  HomeViewController.m
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HomeViewController.h"
#import "ChannelModel.h"
#import "channelLab.h"
#import "HomeCollectionViewCell.h"


@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *ChannelScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *NewsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;

//数据接收
@property (nonatomic, strong) NSArray *dataArr;

//标签数组
@property (nonatomic, strong) NSMutableArray *labM;
@end

@implementation HomeViewController
-(NSMutableArray *)labM
{
    if (_labM == nil) {
        _labM = [NSMutableArray array];
    }
    return _labM;
}

-(NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [ChannelModel channels];
    }
    return _dataArr;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //设置item的大小
    self.FlowLayout.itemSize = self.NewsCollectionView.bounds.size;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSLog(@"%@",[ChannelModel channels]);
    //sv跟nav同时使用的话,sv会往下偏移一定的距离,如果不想偏移的话,设置automaticallyAdjustsScrollViewInsets为no 也可以通过sb设置
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatChannelLab];
}
- (void)creatChannelLab
{
    int LabW = 80;
    int LabH = self.ChannelScrollView.bounds.size.height;
    for (int i = 0;i < self.dataArr.count ; i ++) {
        channelLab *lab = [[channelLab alloc]init];
        //给lab设置frame
        lab.frame = CGRectMake(LabW * i, 0, LabW, LabH);
        
        //获取model
        ChannelModel *model = self.dataArr[i];
        //给lab赋值
        lab.text = model.tname;
        //设置的lab的背景颜色
//        lab.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        
        //给lab设置tag
        lab.tag = i;
        
        
        [self.ChannelScrollView addSubview:lab];
        //设置ChannelScrollView滚动
        self.ChannelScrollView.contentSize = CGSizeMake(LabW *self.dataArr.count, 0);
        
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [lab addGestureRecognizer:tap];
        //设置lab可以点击
        lab.userInteractionEnabled = YES;
        
        //把lab添加到频道数组里面
        [self.labM addObject:lab];
    }
    
}
//点击频道的方法
-(void)tapClick:(UIGestureRecognizer *)tap
{
    //获取选中的lab
    channelLab *lab = (channelLab *)tap.view;
    
    // 计算选中的label剧中时,要滚动的偏移量
    CGFloat labOffsetX = lab.center.x - self.view.bounds.size.width/2;
    // 限制最大和最小的偏移量
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.ChannelScrollView.contentSize.width - self.view.bounds.size.width;
    
    if (labOffsetX < minOffsetX) {
        labOffsetX = 0;
    }else if(labOffsetX > maxOffsetX)
    {
        labOffsetX = maxOffsetX;
    }
    
    // 设置频道滚动视图的滚动
    [self.ChannelScrollView setContentOffset:CGPointMake(labOffsetX, 0) animated:YES];

    #pragma mark - 点击频道标签居中时,collectionView也跟着联动
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:lab.tag inSection:0];
    [self.NewsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
}

#pragma mark - 监听底部conllectionView的滚动 : 滚动结束的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算滚动到第几个索引
    NSInteger index = scrollView.contentOffset.x /scrollView.bounds.size.width;
    //根据标签去找lab
    channelLab *lab = self.labM[index];
    
    //lab滚动的偏移量
    CGFloat labOffSetX = lab.center.x - self.view.bounds.size.width/2;
    // 限制最大和最小的偏移量
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.ChannelScrollView.contentSize.width - self.view.bounds.size.width;
    
    if (labOffSetX < minOffsetX) {
        labOffSetX = 0;
    }else if(labOffSetX > maxOffsetX)
    {
        labOffSetX = maxOffsetX;
    }
    
    
    //真正的滚动channelScollview
    [self.ChannelScrollView setContentOffset:CGPointMake(labOffSetX, 0) animated:YES];
    
    
}

#pragma mark CollectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
//HomeViewController -> HomeCollectionViewCell - >NewsTableViewController ->NewsModel 
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%ld",(long)indexPath.row);
    
 
    
    //CollectionView是用来承载UItableview
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionCell" forIndexPath:indexPath];
      ChannelModel *model = self.dataArr[indexPath.item];
//    NSLog(@"model.tid %@",model.tid);
    
    NSString *urlstr = [NSString stringWithFormat:@"article/list/%@/0-20.html",model.tid];
    cell.urlstr = urlstr;
    
    
    
    return cell;
}

@end
