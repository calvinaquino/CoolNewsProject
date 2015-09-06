//
//  ArticleDownloader.m
//  newsApp
//
//  Created by Calvin Gonçalves de Aquino on 9/6/15.
//  Copyright (c) 2015 Calvin Gonçalves de Aquino. All rights reserved.
//

#import "ArticleDownloader.h"
#import "CoreDataController.h"
#import "AFNetworking.h"
#import "Article.h"

static NSString *const kBaseUrl = @"http://www.ckl.io/challenge/";

@implementation ArticleDownloader

+ (void)downloadArticlesWithCompletion:(void (^)(BOOL))completionBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kBaseUrl parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray *articles) {
        [ArticleDownloader processArticles:articles];
        if (completionBlock) {
            completionBlock(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (completionBlock) {
            completionBlock(NO);
        }
    }];
}

+ (void)processArticles:(NSArray *)articles {
    for (NSDictionary *articleDictionary in articles) {
        if (![CoreDataController articleWithTitle:articleDictionary[@"title"]]) {
            Article *newArticle = [CoreDataController newArticle];
            [newArticle populateWithDictionary:articleDictionary];
        }
    }
    [CoreDataController saveContext];
}

@end
