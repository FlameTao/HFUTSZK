//
//  SubjectModel.m
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import "SubjectModel.h"
#import "FMDB.h"

@implementation SubjectModel

+ (NSMutableArray*)subjectTestWithCourse:(NSInteger)course {
    NSArray *temp1 = [SubjectModel subjectWithCourse:course ByType:1];
    NSArray *temp2 = [SubjectModel subjectWithCourse:course ByType:2];
    NSArray *temp3 = [SubjectModel subjectWithCourse:course ByType:3];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSMutableArray *temp1Result = [[NSMutableArray alloc] init];
    NSMutableArray *temp2Result = [[NSMutableArray alloc] init];
    NSMutableArray *temp3Result = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<temp1.count; i++) {
        [temp1Result addObject:[NSNumber numberWithInteger:i]];
    }
    for (NSInteger i=0; i<temp2.count; i++) {
        [temp2Result addObject:[NSNumber numberWithInteger:i]];
    }
    for (NSInteger i=0; i<temp3.count; i++) {
        [temp3Result addObject:[NSNumber numberWithInteger:i]];
    }
    for (NSInteger i=0; i<15; i++) {
        NSInteger pos = arc4random()%temp1Result.count;
        NSInteger selectNum = [[temp1Result objectAtIndex:pos] integerValue];
        SubjectModel *selectSub = [temp1 objectAtIndex:selectNum];
        [result addObject:selectSub];
        [temp1Result removeObjectAtIndex:pos];
    }
    for (NSInteger i=0; i<20; i++) {
        NSInteger pos = arc4random()%temp2Result.count;
        NSInteger selectNum = [[temp2Result objectAtIndex:pos] integerValue];
        SubjectModel *selectSub = [temp2 objectAtIndex:selectNum];
        [result addObject:selectSub];
        [temp2Result removeObjectAtIndex:pos];
    }
    for (NSInteger i=0; i<15; i++) {
        NSInteger pos = arc4random()%temp3Result.count;
        NSInteger selectNum = [[temp3Result objectAtIndex:pos] integerValue];
        SubjectModel *selectSub = [temp3 objectAtIndex:selectNum];
        [result addObject:selectSub];
        [temp3Result removeObjectAtIndex:pos];
    }
    return result;
}

+ (BOOL)updateCollection:(NSInteger)collection withCourse:(NSInteger)course ID:(NSInteger)ID {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [db open];
    if (isOpen) {
        NSString *sql;
        if (course == 0) {
            sql = [NSString stringWithFormat:@"update marxism set collection = %ld where _id = %ld;", (long)collection, (long)ID];
        } else if (course == 1) {
            sql = [NSString stringWithFormat:@"update sxddxyyfljc set collection = %ld where _id = %ld;", (long)collection, (long)ID];
        } else if (course == 2) {
            sql = [NSString stringWithFormat:@"update mzdsxhzgteshzylltx set collection = %ld where _id = %ld;", (long)collection, (long)ID];
        } else {
            sql = [NSString stringWithFormat:@"update zgjdsgy set collection = %ld where _id = %ld;", (long)collection, (long)ID];
        }
        BOOL finish = [db executeUpdate:sql];
        [db close];
        if (finish) {
            return YES;
        }
    }
    return NO;
}

+ (NSMutableArray*)subjectCollectionWithCourse:(NSInteger)course {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [db open];
    if (isOpen) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        NSString *sql;
        if (course == 0) {
            sql = @"select * from marxism where collection=1;";
        } else if (course == 1) {
            sql = @"select * from sxddxyyfljc where collection=1;";
        } else if (course == 2) {
            sql = @"select * from mzdsxhzgteshzylltx where collection=1;";
        } else {
            sql = @"select * from zgjdsgy where collection=1;";
        }
        
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            SubjectModel *model = [[SubjectModel alloc] init];
            model.subjectID = [rs intForColumn:@"_id"];
            model.subjectType = [rs intForColumn:@"type"];
            model.subjectContent = [rs stringForColumn:@"subject"];
            if (model.subjectType == 1) {
                model.subjectOptionA = @"对";
                model.subjectOptionB = @"错";
            } else {
                model.subjectOptionA = [rs stringForColumn:@"a"];
                model.subjectOptionB = [rs stringForColumn:@"b"];
                model.subjectOptionC = [rs stringForColumn:@"c"];
                model.subjectOptionD = [rs stringForColumn:@"d"];
            }
            model.subjectAnswer = [rs stringForColumn:@"answer"];
            model.subjectChapter = [rs intForColumn:@"chapter"];
            model.subjectCollection = [rs intForColumn:@"collection"];
            model.subjectMyAnswer = [rs stringForColumn:@"myAnswer"];
            [result addObject:model];
        }
        [db close];
        return result;
    } else {
        return nil;
    }
}

+ (BOOL)updateWrongWithSubjectID:(NSInteger)subjectID andCourse:(NSInteger)course andMyAnswer:(NSString*)myAnswer {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [db open];
    if (isOpen) {
        NSString *sql = [NSString stringWithFormat:@"insert into wrong values(%ld,%ld,'%@')",(long)subjectID, (long)course, myAnswer];
        BOOL finish = [db executeUpdate:sql];
        if (finish == NO) {
            NSString *sql1 = [NSString stringWithFormat:@"update wrong set wrongAnswer='%@' where _id=%ld and course=%ld", myAnswer, (long)subjectID, (long)course];
            BOOL finish1 = [db executeUpdate:sql1];
            if (finish1) {
                [db close];
                return YES;
            }
        } else {
            [db close];
            return YES;
        }
    }
    return NO;
}

+ (BOOL)deleteWrongSubject:(NSInteger)subjecID andCourse:(NSInteger)course {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [db open];
    if (isOpen) {
        NSString *sql = [NSString stringWithFormat:@"delete from wrong where _id=%ld and course=%ld;", (long)subjecID, (long)course];
        BOOL finish = [db executeUpdate:sql];
        if (finish) {
            return YES;
        }
    }
    return NO;
}

+ (NSMutableArray*)subjectWrongWithCourse:(NSInteger)course {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [db open];
    if (isOpen) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        NSString *sql;
        if (course == 0) {
            sql = @"select * from marxism,wrong where marxism._id=wrong._id and course=0;";
        } else if (course == 1) {
            sql = @"select * from sxddxyyfljc,wrong where sxddxyyfljc._id=wrong._id and course=1;";
        } else if (course == 2) {
            sql = @"select * from mzdsxhzgteshzylltx,wrong where mzdsxhzgteshzylltx._id=wrong._id and course=2;";
        } else {
            sql = @"select * from zgjdsgy,wrong where zgjdsgy._id=wrong._id and course=3;";
        }
        
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            SubjectModel *model = [[SubjectModel alloc] init];
            model.subjectID = [rs intForColumn:@"_id"];
            model.subjectType = [rs intForColumn:@"type"];
            model.subjectContent = [rs stringForColumn:@"subject"];
            if (model.subjectType == 1) {
                model.subjectOptionA = @"对";
                model.subjectOptionB = @"错";
            } else {
                model.subjectOptionA = [rs stringForColumn:@"a"];
                model.subjectOptionB = [rs stringForColumn:@"b"];
                model.subjectOptionC = [rs stringForColumn:@"c"];
                model.subjectOptionD = [rs stringForColumn:@"d"];
            }
            model.subjectAnswer = [rs stringForColumn:@"answer"];
            model.subjectChapter = [rs intForColumn:@"chapter"];
            model.subjectCollection = [rs intForColumn:@"collection"];
            model.subjectMyAnswer = [rs stringForColumn:@"wrongAnswer"];
            [result addObject:model];
        }
        [db close];
        return result;
    } else {
        return nil;
    }
}

+ (NSMutableArray*)subjectWithCourse:(NSInteger)course {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [db open];
    if (isOpen) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        NSString *sql;
        if (course == 0) {
            sql = @"select * from marxism;";
        } else if (course == 1) {
            sql = @"select * from sxddxyyfljc;";
        } else if (course == 2) {
            sql = @"select * from mzdsxhzgteshzylltx;";
        } else {
            sql = @"select * from zgjdsgy;";
        }
        
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            SubjectModel *model = [[SubjectModel alloc] init];
            model.subjectID = [rs intForColumn:@"_id"];
            model.subjectType = [rs intForColumn:@"type"];
            model.subjectContent = [rs stringForColumn:@"subject"];
            if (model.subjectType == 1) {
                model.subjectOptionA = @"对";
                model.subjectOptionB = @"错";
            } else {
                model.subjectOptionA = [rs stringForColumn:@"a"];
                model.subjectOptionB = [rs stringForColumn:@"b"];
                model.subjectOptionC = [rs stringForColumn:@"c"];
                model.subjectOptionD = [rs stringForColumn:@"d"];
            }
            model.subjectAnswer = [rs stringForColumn:@"answer"];
            model.subjectChapter = [rs intForColumn:@"chapter"];
            model.subjectCollection = [rs intForColumn:@"collection"];
            model.subjectMyAnswer = [rs stringForColumn:@"myAnswer"];
            [result addObject:model];
        }
        [db close];
        return result;
    } else {
        return nil;
    }
}

+ (SubjectModel*)subjectWithCourse:(NSInteger)course ID:(NSInteger)ID {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [db open];
    if (isOpen) {
        SubjectModel *model = [[SubjectModel alloc] init];
        NSString *sql;
        if (course == 0) {
            sql = [NSString stringWithFormat:@"select * from marxism where _id = %ld;", (long)ID];
        } else if (course == 1) {
            sql = [NSString stringWithFormat:@"select * from sxddxyyfljc where _id = %ld;", (long)ID];
        } else if (course == 2) {
            sql = [NSString stringWithFormat:@"select * from mzdsxhzgteshzylltx where _id = %ld;", (long)ID];
        } else {
            sql = [NSString stringWithFormat:@"select * from zgjdsgy where _id = %ld;", (long)ID];
        }
        
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            model.subjectID = [result intForColumn:@"_id"];
            model.subjectType = [result intForColumn:@"type"];
            model.subjectContent = [result stringForColumn:@"subject"];
            if (model.subjectType == 1) {
                model.subjectOptionA = @"对";
                model.subjectOptionB = @"错";
            } else {
                model.subjectOptionA = [result stringForColumn:@"a"];
                model.subjectOptionB = [result stringForColumn:@"b"];
                model.subjectOptionC = [result stringForColumn:@"c"];
                model.subjectOptionD = [result stringForColumn:@"d"];
            }
            model.subjectAnswer = [result stringForColumn:@"answer"];
            model.subjectChapter = [result intForColumn:@"chapter"];
            model.subjectCollection = [result intForColumn:@"collection"];
            model.subjectMyAnswer = [result stringForColumn:@"myAnswer"];
        }
        [db close];
        return model;
    } else {
        return nil;
    }
}

+ (NSMutableArray*) subjectWithCourse:(NSInteger)course ByChapter:(NSInteger)chapter {
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [db open];
    if (isOpen) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        NSString *sql;
        if (course == 0) {
            sql = [NSString stringWithFormat:@"select * from marxism where chapter = %ld;", (long)chapter];
        } else if (course == 1) {
            sql = [NSString stringWithFormat:@"select * from sxddxyyfljc where chapter = %ld;", (long)chapter];
        } else if (course == 2) {
            sql = [NSString stringWithFormat:@"select * from mzdsxhzgteshzylltx where chapter = %ld;", (long)chapter];
        } else {
            sql = [NSString stringWithFormat:@"select * from zgjdsgy where chapter = %ld;", (long)chapter];
        }
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            SubjectModel *model = [[SubjectModel alloc] init];
            model.subjectID = [rs intForColumn:@"_id"];
            model.subjectType = [rs intForColumn:@"type"];
            model.subjectContent = [rs stringForColumn:@"subject"];
            if (model.subjectType == 1) {
                model.subjectOptionA = @"对";
                model.subjectOptionB = @"错";
            } else {
                model.subjectOptionA = [rs stringForColumn:@"a"];
                model.subjectOptionB = [rs stringForColumn:@"b"];
                model.subjectOptionC = [rs stringForColumn:@"c"];
                model.subjectOptionD = [rs stringForColumn:@"d"];
            }
            model.subjectAnswer = [rs stringForColumn:@"answer"];
            model.subjectChapter = [rs intForColumn:@"chapter"];
            model.subjectCollection = [rs intForColumn:@"collection"];
            model.subjectMyAnswer = [rs stringForColumn:@"myAnswer"];
            [result addObject:model];
        }
        [db close];
        return result;
    }
    return nil;
}

+ (NSMutableArray*)subjectWithCourse:(NSInteger)course ByType:(NSInteger)type {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [db open];
    if (isOpen) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        NSString *sql;
        if (course == 0) {
            sql = [NSString stringWithFormat:@"select * from marxism where type = %ld;", (long)type];
        } else if (course == 1) {
            sql = [NSString stringWithFormat:@"select * from sxddxyyfljc where type = %ld;", (long)type];
        } else if (course == 2) {
            sql = [NSString stringWithFormat:@"select * from mzdsxhzgteshzylltx where type = %ld;", (long)type];
        } else {
            sql = [NSString stringWithFormat:@"select * from zgjdsgy where type = %ld;", (long)type];
        }
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            SubjectModel *model = [[SubjectModel alloc] init];
            model.subjectID = [rs intForColumn:@"_id"];
            model.subjectType = [rs intForColumn:@"type"];
            model.subjectContent = [rs stringForColumn:@"subject"];
            if (model.subjectType == 1) {
                model.subjectOptionA = @"对";
                model.subjectOptionB = @"错";
            } else {
                model.subjectOptionA = [rs stringForColumn:@"a"];
                model.subjectOptionB = [rs stringForColumn:@"b"];
                model.subjectOptionC = [rs stringForColumn:@"c"];
                model.subjectOptionD = [rs stringForColumn:@"d"];
            }
            model.subjectAnswer = [rs stringForColumn:@"answer"];
            model.subjectChapter = [rs intForColumn:@"chapter"];
            model.subjectCollection = [rs intForColumn:@"collection"];
            model.subjectMyAnswer = [rs stringForColumn:@"myAnswer"];
            [result addObject:model];
        }
        [db close];
        return result;
    }
    return nil;
}

+ (NSInteger)countOfCourse:(NSInteger)course {
    NSInteger count = 0;
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *dbPath = [path stringByAppendingString:@"szk_2016061902.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [db open];
    if (isOpen) {
        NSString *sql;
        if (course == 0) {
            sql = @"select _id from marxism;";
        } else if (course == 1) {
            sql = @"select _id from sxddxyyfljc;";
        } else if (course == 2) {
            sql = @"select _id from mzdsxhzgteshzylltx;";
        } else {
            sql = @"select * from zgjdsgy where type = %ld;";
        }
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            count++;
        }
        return count;
    }
    return -1;
}

@end
