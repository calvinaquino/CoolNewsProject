//
//  ArticleDetailViewController.m
//  newsApp
//
//  Created by Calvin Gonçalves de Aquino on 9/6/15.
//  Copyright (c) 2015 Calvin Gon&#231;alves de Aquino. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "Article.h"
#import "Image.h"
#import "UIView+Rect.h"
#import "CoreDataController.h"

@interface ArticleDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *articleTitleLabel;
@property (nonatomic, strong) UIImageView *articleImageView;
@property (nonatomic, strong) UILabel *articleDateLabel;
@property (nonatomic, strong) UILabel *articleAuthorsLabel;
@property (nonatomic, strong) UITextView *articleContentTextView;

@end

static CGFloat const kMargin = 20.0f;

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupArticleDetailSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.article) {
        [self populateSubviews];
    }
}

- (void)setupArticleDetailSubviews {
    self.scrollView = [[UIScrollView alloc] init];
    
    self.articleTitleLabel = [[UILabel alloc] init];
    
    self.articleImageView = [[UIImageView alloc] init];
    
    self.articleDateLabel = [[UILabel alloc] init];
    
    self.articleContentTextView = [[UITextView alloc] init];
    self.articleContentTextView.userInteractionEnabled = NO;
    
    self.articleAuthorsLabel = [[UILabel alloc] init];
    
    [self.scrollView addSubview:self.articleTitleLabel];
    [self.scrollView addSubview:self.articleImageView];
    [self.scrollView addSubview:self.articleDateLabel];
    [self.scrollView addSubview:self.articleContentTextView];
    [self.scrollView addSubview:self.articleAuthorsLabel];
    
    [self.view addSubview:self.scrollView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.articleTitleLabel sizeToFit];
    self.articleTitleLabel.left = kMargin;
    self.articleTitleLabel.top = kMargin;
    self.articleTitleLabel.width = self.view.width - (kMargin * 2);
    
    [self.articleDateLabel sizeToFit];
    self.articleDateLabel.left = kMargin;
    self.articleDateLabel.top = self.articleTitleLabel.bottom + kMargin;
    self.articleDateLabel.width = self.articleTitleLabel.width;
    
    [self.articleContentTextView sizeToFit];
    self.articleContentTextView.left = kMargin;
    self.articleContentTextView.top = self.articleDateLabel.bottom + kMargin;
    self.articleContentTextView.width = self.articleDateLabel.width;
    
    [self.articleAuthorsLabel sizeToFit];
    self.articleAuthorsLabel.left = kMargin;
    self.articleAuthorsLabel.top = self.articleContentTextView.bottom + kMargin;
    self.articleAuthorsLabel.width = self.articleContentTextView.width;
    
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.articleAuthorsLabel.bottom + kMargin);
}

#pragma mark - Accessor Methods

- (void)setArticle:(Article *)article {
    _article = article;
    
    self.title = _article.website;
    
    if (self.isViewLoaded) {
        [self populateSubviews];
    }
}

- (void)populateSubviews {
    self.articleTitleLabel.text = _article.title;
    self.articleDateLabel.text = _article.date;
    self.articleContentTextView.text = _article.content;
    self.articleAuthorsLabel.text = _article.authors;
    
    if (self.article.image.fetchedValue) {
        self.articleImageView.image = [self.article.image imageFromDisk];
    }
    
    if ([self.delegate respondsToSelector:@selector(articleDetailViewController:didOpenArticle:)]) {
        [self.delegate articleDetailViewController:self didOpenArticle:self.article];
    }
    
    [self.view setNeedsLayout];
}

@end
