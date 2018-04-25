//
//  MyFlowLayOut.m
//  仿相册瀑布流
//
//  Created by 刘伟哲 on 2018/4/25.
//  Copyright © 2018年 刘伟哲. All rights reserved.
//

#import "MyFlowLayOut.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height
@implementation MyFlowLayOut

//收集视图调用-准备一次在它的第一个布局中作为第一个消息到布局实例。
//收集视图调用-prepareLayout在布局无效后，在重新请求布局信息之前。
//子类应该始终调用super，如果它们覆盖。
//什么时候调用：collection第一次布局，collectionView刷新的时候也会调用
//作用计算Cell的布局，条件：cell的位置是固定不变的
- (void)prepareLayout{
    [super prepareLayout];
}

//作用：指定一段区域给你这段区域内cell的尺寸
//可一次返回所有的cell尺寸，也可以每隔一个距离返回一个cell
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
//    NSLog(@"%s",__func__);
    
    //设置Cell的尺寸==》UICollectionViewLayoutAttributes
    //越靠近中心点，越大
    //求Cell与中心点距离
    
    //1.获取当前显示Cell的布局
    NSArray* attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];

    for(UICollectionViewLayoutAttributes * attr in attrs){
        //2.计算item中心点与当前中心点的距离取绝对值
        CGFloat delta = fabs((attr.center.x - self.collectionView.contentOffset.x)-self.collectionView.bounds.size.width*0.5);
        //3.计算占总宽度的比例 0.2是缩放比例。 用1减是为了放大
        //delta / (self.collectionView.bounds.size.width * 0.5)。 中心偏移占宽度比
        CGFloat scale = 1 - delta / (self.collectionView.bounds.size.width * 0.5) *0.2;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attrs;
}
//返回YES以使集合视图对几何信息进行布局。
//在滚动时是否允许刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
//手指一松开调用
//作用：确定最终偏移量
//定位：距离中心点越近，这个Cell最终展示到中心点
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    //拖动比较快，最终偏移量不等于手指离开时偏移量
    // 0这是实际最终偏移量。
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    //0获取最终显示的区域
    CGRect targetRect = CGRectMake(targetP.x, 0, self.collectionView.bounds.size.width, MAXFLOAT);
    //1获取最终显示的Cell
    NSArray* attrs = [super layoutAttributesForElementsInRect:targetRect];
    CGFloat minDelta = MAXFLOAT;
    for(UICollectionViewLayoutAttributes * attr in attrs){
        //获取中心点距离中心距离
        CGFloat delta = (attr.center.x - self.collectionView.contentOffset.x) - self.collectionView.bounds.size.width/2;
        if(fabs(delta) < fabs(minDelta)){
            minDelta = delta;
        }
        NSLog(@"==%f==%f==",minDelta,delta);
    }
    targetP.x +=minDelta;
    
    if(targetP.x < 0){
        targetP.x = 0;
    }
    
    return targetP;
}
//子类必须重写此方法，并使用它返回集合视图内容的宽度和高度。这些值表示所有内容的宽度和高度，而不仅仅是当前可见的内容。集合视图使用这些信息来配置自己的内容大小以方便滚动。（滚动范围）
- (CGSize)collectionViewContentSize{
    return [super collectionViewContentSize];
}

@end
