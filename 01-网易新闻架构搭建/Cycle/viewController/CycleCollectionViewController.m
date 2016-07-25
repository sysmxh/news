//
//  CycleCollectionViewController.m
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CycleCollectionViewController.h"
#import "CycleModel.h"
#import "CycleCollectionViewCell.h"


@interface CycleCollectionViewController ()
//数据接收
@property (nonatomic, strong) NSArray *dataArr;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;

@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation CycleCollectionViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //设置cell的大小
    self.FlowLayout.itemSize = self.collectionView.bounds.size;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createPageControl];
    
    [self loadCycleModelData];
}
/// 创建pageControl
- (void)createPageControl
{
    self.pageControl = [[UIPageControl alloc]init];
    
    [self.view addSubview:self.pageControl];
    //设置选中的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //设置未选中的颜色
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    
}
//下载数据
- (void)loadCycleModelData{
    
    [CycleModel loadCycleDataWithUrlstr:@"ad/headline/0-4.html" successBlock:^(NSArray *listArr) {
        
        self.dataArr = listArr;
        //刷新ui
        [self.collectionView reloadData];
        
        //设置pagecontrol
        //设置个数
        self.pageControl.numberOfPages = self.dataArr.count;
        
        //获取pageControl的size
        CGSize pageControlSize = [self.pageControl sizeForNumberOfPages:self.dataArr.count];
        //pageControl 的frame
        CGFloat pageControlX = self.view.bounds.size.width - pageControlSize.width - 10;
        
        CGFloat pageControlY = self.view.bounds.size.height - pageControlSize.height;
        
        self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);
        
//        刷新完collectionView之后,默默的把item滚动到第4个 (cycleList.count)
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataArr.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
        
        
    } failBlock:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
}
//滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     // 计算当前在第几个item
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    //设置pageControl跟着滚动
    self.pageControl.currentPage = index%self.dataArr.count;
    //准备索引
    NSIndexPath *indexPath;
    
    // 重新获取item的总个数 : 因为前面加倍了的
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    //滚动到最前面的情况
    if (index == 0) {
        indexPath = [NSIndexPath indexPathForItem:self.dataArr.count inSection:0];
    }else if (index == items - 1)
    {
        //滚动到最后面的情况
        indexPath = [NSIndexPath indexPathForItem:self.dataArr.count - 1 inSection:0];
    }
    
    //滚动collectionView
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count*2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCell" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor redColor];
    
    //获取model
    CycleModel *model = self.dataArr[indexPath.item%self.dataArr.count];
    cell.model = model;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
