//
//  ScholarSearchRequest.m
//  LegalRef
//
//  Created by Sumedha Pramod on 7/9/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import "ScholarSearchRequest.h"
#import <AFNetworking.h>
#import <TBXML+NSDictionary.h>

@implementation ScholarSearchRequest {
    NSMutableArray *case_results;
}

- (void) search:(NSString *) prompt {
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.casebriefs.com/?s=%@&feed=rss2", prompt]]];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

        if (!error) {
            NSDictionary *dict = [TBXML dictionaryWithXMLData:data error:&error];
            NSArray *results = [[NSArray alloc] initWithObjects:dict[@"rss"][@"channel"][@"item"], nil];
            NSLog(@"%@", results);
        } else {
            NSLog(@"ERROR: %@", error);
        }
    }];

//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:[NSString stringWithFormat:@"http://scholar.google.com/scholar?q=%@&btnG=&hl=en&as_sdt=2006", prompt] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"RESPONSE: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
}

@end
