//
//  ArticleTableViewCell.m
//  newsApp
//
//  Created by Calvin Gonçalves de Aquino on 9/7/15.
//  Copyright (c) 2015 Calvin Gon&#231;alves de Aquino. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "Article.h"
#import "Image.h"
#import "UIView+Rect.h"

static CGFloat const kMargin = 10.f;
static CGFloat const kImageWidth = 80.f;
static CGFloat const kImageHeight = 80.f;

@interface ArticleTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UIImageView *articleImageView;
@property (nonatomic, strong) UIView *readStripeView;

@end

@implementation ArticleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.6];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.minimumScaleFactor = 0.7;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.font = [UIFont systemFontOfSize:12];
    self.dateLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.dateLabel.textAlignment = NSTextAlignmentLeft;
    self.dateLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    self.dateLabel.minimumScaleFactor = 0.5;
    self.dateLabel.adjustsFontSizeToFitWidth = YES;
    
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.font = [UIFont systemFontOfSize:12];
    self.authorLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.authorLabel.textAlignment = NSTextAlignmentLeft;
    self.authorLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    self.authorLabel.minimumScaleFactor = 0.5;
    self.authorLabel.adjustsFontSizeToFitWidth = YES;
    
    self.articleImageView = [[UIImageView alloc] init];
    self.articleImageView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    self.articleImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.readStripeView = [[UIView alloc] init];
    self.readStripeView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
    self.readStripeView.hidden = YES;
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.articleImageView];
    [self.contentView addSubview:self.readStripeView];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = nil;
    self.dateLabel.text = nil;
    self.authorLabel.text = nil;
    self.articleImageView.image = nil;
    self.articleRead = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.articleImageView.top = kMargin;
    self.articleImageView.left = kMargin;
    self.articleImageView.width = kImageWidth;
    self.articleImageView.height = kImageHeight;
    
    CGFloat labelBaseWidth = self.contentView.width - self.articleImageView.right - (kMargin *2);
    
    [self.titleLabel sizeToFit];
    self.titleLabel.top = kMargin;
    self.titleLabel.left = self.articleImageView.right + kMargin;
    self.titleLabel.width = labelBaseWidth;
    
    [self.authorLabel sizeToFit];
    self.authorLabel.bottom = self.articleImageView.bottom;
    self.authorLabel.left = self.titleLabel.left;
    self.authorLabel.width = (labelBaseWidth - kMargin)/2;
    
    [self.dateLabel sizeToFit];
    self.dateLabel.bottom = self.authorLabel.bottom;
    self.dateLabel.right = self.contentView.width - kMargin;
    self.dateLabel.width = self.titleLabel.width;
    
    self.readStripeView.top = 0;
    self.readStripeView.height = self.contentView.height;
    self.readStripeView.width = 10.f;
    self.readStripeView.right = self.contentView.right;
}

- (void)setArticle:(Article *)article {
    _article = article;
    
    self.titleLabel.text = article.title;
    self.dateLabel.text = article.date;
    self.authorLabel.text = article.authors;
    self.articleRead = article.readValue;
    
    if (self.article.image.fetchedValue) {
        self.articleImageView.image = [self.article.image imageFromDisk];
    }
    
    [self.contentView setNeedsLayout];
}

- (void)setArticleRead:(BOOL)articleRead {
    _articleRead = articleRead;
    
    self.readStripeView.hidden = !articleRead;
}

- (void)updateImage {
    if (self.article.image.fetchedValue) {
        self.articleImageView.image = [self.article.image imageFromDisk];
    }
}

+ (CGFloat)height {
    return kImageHeight + (kMargin * 2);
}

+ (NSString *)identifier {
    return NSStringFromClass(self.class);
}

@end
