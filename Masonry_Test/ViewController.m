//
//  ViewController.m
//  Masonry_Test
//
//  Created by Geraint on 2018/11/19.
//  Copyright © 2018 kilolumen. All rights reserved.
//

#import "ViewController.h"
//#import <Masonry/Masonry.h>
#import "UIView+Masonry_EqualToGap.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSubViews];
    
}


//关于UIView重新布局相关的API，主要用以下三个API：
/**
 
 - (void)setNeedsLayout  标记为需要重新布局
 - (void)layoutIfNeeded  查看当前视图是否被标记需要重新布局，有则在内部调用layoutSubviews方法进行重新布局
 - (void)layoutSubviews  重写当前方法，在内部完成重新布局操作
 
 */
- (void)layoutSubViews {
    
    UIView *uv = [[UIView alloc]init];
    uv.backgroundColor = [UIColor orangeColor];
    
    // ******        在 AutoLayout 之前，一定要先将viewr添加到superView上，否则会报错  ******
    [self.view addSubview:uv];
    [uv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view); // 将uv居中
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    UIView *uv1 = [[UIView alloc] init];
    uv1.backgroundColor = [UIColor blueColor];
    [uv addSubview:uv1];
    [uv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        // 让一个view略小于其superView（边距为10）(and,with可以省略不写)
        make.edges.equalTo(uv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        
        /* 等价于：
         make.top.equalTo(uv).with.offset(10);
         make.left.equalTo(uv).with.offset(10);
         make.bottom.equalTo(uv).with.offset(-10);
         make.right.equalTo(uv).with.offset(-10);
         
         */
        
        /* 也等价于：边距10
         make.top.left.bottom.and.right.equalTo(uv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
         */
        
    }];
    
    // 3、 让两个高度为 150 的view垂直居中且等宽且等间隔排列，间隔为10（自动计算其宽度）
    UIView *uv2 = [[UIView alloc] init];
    uv2.backgroundColor = [UIColor redColor];
    [uv1 addSubview:uv2];
    UIView *uv3 = [[UIView alloc] init];
    uv3.backgroundColor = [UIColor yellowColor];
    [uv1 addSubview:uv3];
    
    
    [uv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(uv.mas_centerY);
        make.left.equalTo(uv.mas_left).offset(10);
        make.right.equalTo(uv3.mas_left).offset(-10);
        make.height.mas_equalTo(@150);
        make.width.equalTo(uv3);
    }];
    
    
    [uv3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(uv.mas_centerY);
        make.left.equalTo(uv2.mas_right).offset(10);
        make.right.equalTo(uv.mas_right).offset(-10);
        make.height.mas_equalTo(@150);
        make.width.equalTo(uv2);
    }];
    
    
    //4、【中级】在UIScrollview 顺序排列一些view并自动计算contentSize
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    [uv addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(uv).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    UIView *container = [[UIView alloc] init];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    
    int count = 10;
    UIView *lastView = nil;
//    int i;
    for (int i = 1; i <= count; i++) {
        UIView *suby = [[UIView alloc] init];
        [container addSubview:suby];
        // 指定HSB，参数是：色调（hue），色饱和度（saturation），亮度（brightness），透明度，范围是0-1
        suby.backgroundColor = [UIColor colorWithHue:(arc4random() % 256 / 256.0)
                                          saturation:(arc4random() % 228 / 256.0)
                                          brightness:(arc4random() % 228 / 256.0)
                                               alpha:1];
        
        [suby mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(container);
            make.height.mas_equalTo(@(20*i));
            
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            } else {
                make.top.mas_equalTo(container.mas_top);
            }
            
        }];
        lastView = suby;
//        NSLog(@"i = %d", i);
    }
    
    [container  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
 
    
    
    // 5、【高级】 横向或者纵向等间隙的排列一组view ---> Category【先写zcategory里面的代码】
    UIView *sv11 = [[UIView alloc] init];
    UIView *sv12 = [[UIView alloc] init];
    UIView *sv13 = [[UIView alloc] init];
    UIView *sv14 = [[UIView alloc] init];
    UIView *sv15 = [[UIView alloc] init];
    
    sv11.backgroundColor = [UIColor greenColor];
    sv12.backgroundColor = [UIColor greenColor];
    sv13.backgroundColor = [UIColor greenColor];
    sv14.backgroundColor = [UIColor greenColor];
    sv15.backgroundColor = [UIColor greenColor];
    
    [uv addSubview:sv11];
    [uv addSubview:sv12];
    [uv addSubview:sv13];
    [uv addSubview:sv14];
    [uv addSubview:sv15];
    
    // 给予不同的大小 ， 测试结果
    [sv11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@[sv12, sv13]);
        make.centerX.equalTo(@[sv14, sv15]);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [sv12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    [sv13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [sv14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    [sv15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 60));
    }];
    
    [uv distributeSpacingHorizontallWith:@[sv11, sv12, sv13]];  // 水平
    [uv distributeSpacingVerticallyWith:@[sv11, sv14, sv15]];   // 垂直 ( ͡° ͜ʖ ͡°)
    
    
    
}


@end
