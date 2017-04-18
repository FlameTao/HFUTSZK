//
//  SubjectModel.h
//  HFUTSZK
//
//  Created by Flame on 2017/3/16.
//  Copyright © 2017年 HFUTStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectModel : NSObject

@property (nonatomic) NSInteger subjectID;
@property (nonatomic) NSInteger subjectType;
@property (nonatomic, strong) NSString *subjectContent;
@property (nonatomic, strong) NSString *subjectOptionA;
@property (nonatomic, strong) NSString *subjectOptionB;
@property (nonatomic, strong) NSString *subjectOptionC;
@property (nonatomic, strong) NSString *subjectOptionD;
@property (nonatomic, strong) NSString *subjectAnswer;
@property (nonatomic) NSInteger subjectChapter;
@property (nonatomic) NSInteger subjectCollection;
@property (nonatomic, strong) NSString *subjectMyAnswer;

+ (NSMutableArray*)subjectWithCourse:(NSInteger)course ID:(NSInteger)ID; // 按 _id 取指定题

+ (NSMutableArray*)subjectWithCourse:(NSInteger)course ByChapter:(NSInteger)chapter; // 按章节返回保存题目的数组

+ (NSMutableArray*)subjectWithCourse:(NSInteger)course ByType:(NSInteger)type; // 按类型返回保存题目的数组

+ (NSMutableArray*)subjectWithCourse:(NSInteger)course; // 按课程返回所有题目

+ (NSInteger)countOfCourse:(NSInteger)course; // 返回题目数量， -1表示失败

+ (BOOL)updateCollection:(NSInteger)collection withCourse:(NSInteger)course ID:(NSInteger)ID; // 更新是否收藏 // 0表示不收藏，1表示收藏

+ (BOOL)updateWrongWithSubjectID:(NSInteger)subjectID andCourse:(NSInteger)course andMyAnswer:(NSString*)myAnswer;  //更新错题答案

+ (NSMutableArray*)subjectWrongWithCourse:(NSInteger)course; // 返回错题

+ (NSMutableArray*)subjectCollectionWithCourse:(NSInteger)course;  // 返回收藏的题

+ (BOOL)deleteWrongSubject:(NSInteger)subjecID andCourse:(NSInteger)course;  // 删除我的错题里的错题

+ (NSMutableArray*)subjectTestWithCourse:(NSInteger)course;

@end
