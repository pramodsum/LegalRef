//
//  ScholarSearchRequest.h
//  LegalRef
//
//  Created by Sumedha Pramod on 7/9/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScholarSearchRequest : NSObject

- (void) search:(NSString *) prompt;
- (NSArray *) getResults;

@end
