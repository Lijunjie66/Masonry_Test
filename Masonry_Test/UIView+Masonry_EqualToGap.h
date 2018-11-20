//
//  UIView+Masonry_EqualToGap.h
//  Masonry_Test
//
//  Created by Geraint on 2018/11/19.
//  Copyright © 2018 kilolumen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Masonry_EqualToGap)

// 水平
- (void) distributeSpacingHorizontallWith:(NSArray *)views;
// 垂直
- (void) distributeSpacingVerticallyWith:(NSArray *)views;

@end

NS_ASSUME_NONNULL_END
