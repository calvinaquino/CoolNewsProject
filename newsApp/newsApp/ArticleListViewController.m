//
//  ViewController.m
//  newsApp
//
//  Created by Calvin Gonçalves de Aquino on 9/6/15.
//  Copyright (c) 2015 Calvin Gonçalves de Aquino. All rights reserved.
//

#import "ArticleListViewController.h"
#import "ArticleDetailViewController.h"
#import "ArticleDownloader.h"
#import "CoreDataController.h"
#import "Article.h"
#import "Image.h"
#import "ArticleTableViewCell.h"

@interface ArticleListViewController () <UITableViewDataSource, UITableViewDelegate, ArticleDetailDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, assign) BOOL firstTimeRefresh;

@end

@implementation ArticleListViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleFetchedImages:) name:kArticleDownloaderImageFetchedNotification object:nil];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Articles";
    self.view.backgroundColor = [UIColor whiteColor];
    self.firstTimeRefresh = YES;
    
    [self setupTableView];
    [self loadDownloadedArticles];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:ArticleTableViewCell.class forCellReuseIdentifier:[ArticleTableViewCell identifier]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchArticles) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self.view addSubview:self.tableView];
}

- (void)loadDownloadedArticles {
    self.articles = [CoreDataController allArticles];
    if (self.articles.count) {
        [self.tableView reloadData];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.firstTimeRefresh) {
        self.firstTimeRefresh = NO;
        [self fetchArticles];
    }
}


#pragma mark - Private Methods

- (void)fetchArticles {
    __weak typeof(self) weakSelf = self;
    [ArticleDownloader downloadArticlesWithCompletion:^(BOOL success) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (weakSelf.refreshControl.isRefreshing) {
                [weakSelf.refreshControl endRefreshing];
            }
            weakSelf.articles = [CoreDataController allArticles];
            [weakSelf.tableView reloadData];
        }];
    }];
}

- (void)handleFetchedImages:(NSNotification *)notification {
    Article *article = notification.userInfo[kArticleDownloaderImageFetchedForArticleNotification];
    NSInteger indexOfArticle = [self.articles indexOfObject:article];
    NSArray *visibleIndexPaths = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *visibleIndexPath in visibleIndexPaths) {
        if (visibleIndexPath.row == indexOfArticle) {
            __weak typeof(self) weakSelf = self;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [weakSelf.tableView reloadRowsAtIndexPaths:@[visibleIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        }
    }
}


#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ArticleTableViewCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell *cell = (ArticleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[ArticleTableViewCell identifier] forIndexPath:indexPath];
    
    Article *article = self.articles[indexPath.row];
    cell.article = article;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    ArticleDetailViewController *articleDetailViewController = [[ArticleDetailViewController alloc] init];
    articleDetailViewController.delegate = self;
    articleDetailViewController.article = self.articles[indexPath.row];
    [self.navigationController pushViewController:articleDetailViewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    Article *article = weakSelf.articles[indexPath.row];
    BOOL isRead = article.readValue;
    NSString *markReadTitle = isRead ? @"Mark as unread" : @"Mark as read";
    UITableViewRowAction *toggleReadStateAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:markReadTitle handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        article.readValue = !article.readValue;
        [CoreDataController saveContext];
        [weakSelf.tableView setEditing:NO animated:YES];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        Article *deletingArticle = self.articles[indexPath.row];
        [deletingArticle deleteImage];
        [[CoreDataController context] deleteObject:deletingArticle];
        self.articles = [CoreDataController allArticles];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    return @[deleteAction, toggleReadStateAction];
}


#pragma mark - ArticleDetailDelegate

- (void)articleDetailViewController:(ArticleDetailViewController *)articleDetailViewController didOpenArticle:(Article *)article {
    article.readValue = YES;
    [CoreDataController saveContext];
    NSIndexPath *readArticleIndexPath = [NSIndexPath indexPathForRow:[self.articles indexOfObject:article] inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[readArticleIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
