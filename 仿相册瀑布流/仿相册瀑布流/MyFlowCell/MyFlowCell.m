//
//  MyFlowCell.m
//  仿相册瀑布流
//
//  Created by 刘伟哲 on 2018/4/25.
//  Copyright © 2018年 刘伟哲. All rights reserved.
//

#import "MyFlowCell.h"
@interface MyFlowCell()
@property (weak, nonatomic) IBOutlet UIImageView *MyImageView;
@end

@implementation MyFlowCell


-(void)setImage:(UIImage *)Image{
    _Image = Image;
    _MyImageView.image = Image;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
