//
//  NSString+Extent.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/13.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "NSString+Extent.h"

@implementation NSString (Extent)


- (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    NSDictionary *attributes = @{NSFontAttributeName : font};
    CGSize contentSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return contentSize.height;
}

@end
