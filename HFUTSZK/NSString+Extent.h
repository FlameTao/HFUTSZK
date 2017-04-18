//
//  NSString+Extent.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/13.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extent)
- (CGFloat) heightWithText:(NSString*)text font:(UIFont*)font width:(CGFloat)width;
@end
