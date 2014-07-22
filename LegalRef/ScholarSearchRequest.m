//
//  ScholarSearchRequest.m
//  LegalRef
//
//  Created by Sumedha Pramod on 7/9/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import "ScholarSearchRequest.h"
#import <TBXML+NSDictionary.h>
#import "LRCaseObject.h"

@implementation ScholarSearchRequest {
    NSMutableArray *case_results;
}

- (void) search:(NSString *) prompt completion:(void (^)(BOOL finished))completion {
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.casebriefs.com/?s=%@&feed=rss2", prompt]]];
    
    case_results = [[NSMutableArray alloc] init];

    void (^closeCompleteBlock)(BOOL) = ^(BOOL finished) {
        if (!finished) {
            [NSURLConnection sendAsynchronousRequest:urlRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                if (!error) {
                    NSDictionary *dict = [TBXML dictionaryWithXMLData:data error:&error];
                    NSDictionary *results = [[[dict objectForKey:@"rss"] objectForKey:@"channel"] objectForKey:@"item"];
                    //            NSLog(@"Results: %@", results);
                    for(NSDictionary *caseResult in results) {
                        //                NSLog(@"%@", caseResult);
                        LRCaseObject *caseItem = [[LRCaseObject alloc] initFromCaseBriefs:caseResult];
                        [case_results addObject:caseItem];
                    }
                    //            NSLog(@"%@", case_results);
                } else {
                    NSLog(@"ERROR: %@", error);
                }
            }];
        }

        if (completion) {
            completion(finished);
        }
    };
}

- (NSArray *) getResults {
    return case_results;
}

@end
