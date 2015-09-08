//
//  CoreDataController.h
//  newsApp
//
//  Created by Calvin Gonçalves de Aquino on 9/6/15.
//  Copyright (c) 2015 Calvin Gonçalves de Aquino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Article, Image;

@interface CoreDataController : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataController *)sharedInstance;
+ (NSManagedObjectContext *)context;
+ (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

+ (Article *)newArticle;
+ (Image *)newImage;
+ (NSArray *)allArticles;
+ (NSUInteger)countAllArticles;
+ (Article *)articleWithTitle:(NSString *)title;

@end
