//
//  ViewController.m
//  仿相册瀑布流
//
//  Created by 刘伟哲 on 2018/4/25.
//  Copyright © 2018年 刘伟哲. All rights reserved.
//

#import "ViewController.h"
#import "MyFlowCell.h"
#import "MyFlowLayOut.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

/*
     UICollectionView使用要点
         1.创建UICollectionView必须要有布局参数
         2.cell必须通过注册
         3.cell必须自定义，系统cell没有任何子控件
 */

@implementation ViewController

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height
static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyFlowLayOut * LayOut = ({
       MyFlowLayOut * LayOut = [[MyFlowLayOut alloc]init];
        LayOut.minimumLineSpacing = 0;
        LayOut.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        LayOut.itemSize = CGSizeMake(160, 160);
        
        CGFloat margin = (WIDTH - 160)/2;
        LayOut.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        LayOut;
    });
    
    
    
    UICollectionView * collectionView = ({
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, WIDTH, 200) collectionViewLayout:LayOut];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor brownColor];
        [self.view addSubview:collectionView];
        collectionView;
    });
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyFlowCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyFlowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if(cell == nil){
        cell = [[MyFlowCell alloc]init];
    }
    cell.Image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row]];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
