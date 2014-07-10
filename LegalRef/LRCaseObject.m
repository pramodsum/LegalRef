//
//  LRCaseObject.m
//  LegalRef
//
//  Created by Sumedha Pramod on 7/9/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import "LRCaseObject.h"

@implementation LRCaseObject

- (LRCaseObject *) initFromCaseBriefs:(NSDictionary *)caseResult {
    _title = caseResult[@"title"];
    
    _link = caseResult[@"link"];
//    _citationLocation = caseResult[@""];
    
    _pubDate = caseResult[@"pubDate"];
    
    _description = caseResult[@"description"];
    _content = caseResult[@"content:encoded"];
    
    //categories
    
//    NSLog(@"%@", _title);
    
    return self;
}

@end
