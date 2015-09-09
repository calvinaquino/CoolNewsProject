//
//  ArticleTableViewCell.h
//  newsApp
//
//  Created by Calvin Gonçalves de Aquino on 9/7/15.
//  Copyright (c) 2015 Calvin Gon&#231;alves de Aquino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;

@interface ArticleTableViewCell : UITableViewCell

@property (nonatomic, strong) Article *article;
@property (nonatomic, assign) BOOL articleRead;

- (void)updateImage;

+ (NSString *)identifier;
+ (CGFloat)height;

@end
