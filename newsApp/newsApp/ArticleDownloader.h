//
//  ArticleDownloader.h
//  newsApp
//
//  Created by Calvin Gonçalves de Aquino on 9/6/15.
//  Copyright (c) 2015 Calvin Gonçalves de Aquino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleDownloader : NSObject

+ (void)downloadArticlesWithCompletion:(void (^)(BOOL))completionBlock;

@end
