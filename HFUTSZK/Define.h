//
//  Define.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/15.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#ifndef Define_h
#define Define_h

#pragma mark - 颜色
#define FMRGBColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define FMRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define FMRandomColor  KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)
#define FMColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define THEME_COLOR 0x59d6e1


#pragma mark - 关于

#endif /* Define_h */
