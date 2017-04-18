//
//  FanPicture.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/26.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FanPicture : UIView

- (id)initWithFrame:(CGRect)frame dataItems:(NSArray *)dataItems colorItems:(NSArray *)colorItems;

- (void)stroke;

@end
