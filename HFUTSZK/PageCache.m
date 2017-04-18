//
//  PageCache.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/23.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "PageCache.h"

@implementation PageCache

+ (PageCache*)defaultPageCache {
    PageCache *pagecache = [[PageCache alloc] init];
    NSArray *my = [NSArray arrayWithObjects:@"my0", @"my1", @"my2", @"my3", @"my4", @"my5", @"my6", @"my7", @"my", nil];
    NSArray *sx = [NSArray arrayWithObjects:@"sx0", @"sx1", @"sx2", @"sx3", @"sx4", @"sx5", @"sx6", @"sx7", @"sx", nil];
    NSArray *mzt = [NSArray arrayWithObjects:@"mzt0", @"mzt1", @"mzt2", @"mzt3", @"mzt4", @"mzt5", @"mzt6", @"mzt7", @"mzt8", @"mzt8", @"mzt9", @"mzt10", @"mzt11", @"mzt12", @"mzt", nil];
    NSArray *jds = [NSArray arrayWithObjects:@"jds0", @"jds1", @"jds2", @"jds3", @"jds4", @"jds5", @"jds6", @"jds7", @"jds", nil];
    NSArray *wrong = [NSArray arrayWithObjects:@"wrong0", @"wrong1", @"wrong2", @"wrong3", nil];
    NSArray *collection = [NSArray arrayWithObjects:@"collection0", @"collection1", @"collection2", @"collection3", nil];
    pagecache.pageChacheArray = [NSArray arrayWithObjects:my, sx, mzt, jds, wrong, collection, nil];
    return pagecache;
}

@end
