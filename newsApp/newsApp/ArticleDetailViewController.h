//
//  ArticleDetailViewController.h
//  newsApp
//
//  Created by Calvin Gonçalves de Aquino on 9/6/15.
//  Copyright (c) 2015 Calvin Gon&#231;alves de Aquino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;

@protocol ArticleDetailDelegate;

@interface ArticleDetailViewController : UIViewController

@property (nonatomic, assign) Article *article;
@property (nonatomic, weak) id<ArticleDetailDelegate> delegate;

@end

@protocol ArticleDetailDelegate <NSObject>

- (void)articleDetailViewController:(ArticleDetailViewController *)articleDetailViewController didOpenArticle:(Article *)article;

@end
