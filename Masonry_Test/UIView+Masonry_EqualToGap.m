//
//  UIView+Masonry_EqualToGap.m
//  Masonry_Test
//
//  Created by Geraint on 2018/11/19.
//  Copyright © 2018 kilolumen. All rights reserved.
//

#import "UIView+Masonry_EqualToGap.h"
//#import <Masonry/Masonry.h>

// 5、【高级】 横向或者纵向等间隙的排列一组view --->

@implementation UIView (Masonry_EqualToGap)

// 横向
- (void) distributeSpacingHorizontallWith:(NSArray *)views {
    
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    for (int i = 0; i < views.count+1; ++i) {
        UIView *v = [[UIView alloc] init];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    UIView *V0 = spaces[0];
    [V0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(((UIView *)views[0]).mas_centerY);
    }];
    
    UIView *lastSpace = V0;
    for (int i = 0; i < views.count; ++i) {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastSpace.mas_right);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(obj.mas_right);
            make.centerY.equalTo(obj.mas_centerY);
            make.width.equalTo(V0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
    }];
    
}

// 垂直
- (void) distributeSpacingVerticallyWith:(NSArray *)views {
    
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    
    for (int i = 0; i < views.count+1; ++i) {
        UIView *V = [[UIView alloc] init];
        [spaces addObject:V];
        [self addSubview:V];
        
        [V mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(V.mas_height);
        }];
    }
    
    UIView *v0 = spaces[0];
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(((UIView *)views[0]).mas_centerX);
    }];
    
    UIView *lastSpace = v0;
    
    for (int i = 0; i < views.count; ++i) {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastSpace.mas_bottom);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(obj.mas_bottom);
            make.centerX.equalTo(obj.mas_centerX);
            make.height.equalTo(v0);
        }];
        
        lastSpace = space;
        
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
