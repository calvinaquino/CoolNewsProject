//
//  AppDelegate.m
//  newsApp
//
//  Created by Calvin Gonçalves de Aquino on 9/6/15.
//  Copyright (c) 2015 Calvin Gonçalves de Aquino. All rights reserved.
//

#import "AppDelegate.h"
#import "ArticleListViewController.h"
#import "ArticleDetailViewController.h"
#import "CoreDataController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@property (nonatomic, strong) ArticleListViewController *articleListViewController;
@property (nonatomic, strong) ArticleDetailViewController *articleDetailViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
    splitViewController.delegate  = self;
    self.articleListViewController = [[ArticleListViewController alloc] init];
    self.articleDetailViewController = [[ArticleDetailViewController alloc] init];
    
    UINavigationController *masterViewController = [[UINavigationController alloc] initWithRootViewController:self.articleListViewController];
    
    UIViewController *detailViewController = nil;
    if ([UIScreen mainScreen].traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        detailViewController = [[UINavigationController alloc] initWithRootViewController:self.articleDetailViewController];
    } else {
        detailViewController = self.articleDetailViewController;
    }
    
    [splitViewController setViewControllers:@[masterViewController, detailViewController]];
    splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    
    self.window.rootViewController = splitViewController;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [CoreDataController saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [CoreDataController saveContext];
}


#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(id)sender {
    UIViewController *senderVc = (UIViewController *)sender;
    if (senderVc.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        UINavigationController *detailViewController = [[UINavigationController alloc] initWithRootViewController:vc];
        splitViewController.viewControllers = @[splitViewController.viewControllers[0], detailViewController];
        return YES;
    }
    return NO;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if (secondaryViewController) {
        return YES;
    } else {
        return NO;
    }
}

@end
