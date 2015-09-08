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
#import "Image.h"
#import <UIKit/UIKit.h>

NSString *const kBaseUrl = @"http://www.ckl.io/challenge/";
NSString *const kArticleDownloaderImageFetchedNotification = @"kArticleDownloaderImageFetchedNotification";
NSString *const kArticleDownloaderImageFetchedForArticleNotification = @"kArticleDownloaderImageFetchedForArticleNotification";

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
            [ArticleDownloader downloadImage:newArticle.image withCompletion:^(BOOL success) {
                if (success) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kArticleDownloaderImageFetchedNotification object:nil userInfo:@{kArticleDownloaderImageFetchedForArticleNotification: newArticle}];
                }
            }];
        }
    }
    [CoreDataController saveContext];
}

+ (void)downloadImage:(Image *)image withCompletion:(void (^)(BOOL))completionBlock {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:image.url]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, UIImage *imageObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            if (completionBlock) {
                completionBlock(NO);
            }
        } else {
            if (imageObject) {
                NSData *imageData = UIImageJPEGRepresentation(imageObject, 1.0);
                [Image saveImageData:imageData forImage:image];
                image.fetchedValue = YES;
                [CoreDataController saveContext];
                if (completionBlock) {
                    completionBlock(YES);
                }
            }
            if (completionBlock) {
                completionBlock(NO);
            }
        }
    }];
    [dataTask resume];
}

@end
