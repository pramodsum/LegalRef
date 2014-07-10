//
//  LRCaseObject.h
//  LegalRef
//
//  Created by Sumedha Pramod on 7/9/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRCaseObject : NSObject

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSURL *link;
@property (strong, nonatomic) NSString *citationLocation;

@property (strong, nonatomic) NSString *pubDate;

@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *content;

@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) NSString *contentType;
@property (strong, nonatomic) NSString *subjectOfLaw;

- (LRCaseObject *) initFromCaseBriefs:(NSDictionary *)caseResult;

@end
