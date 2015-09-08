//
//  CoreDataController.m
//  newsApp
//
//  Created by Calvin Gonçalves de Aquino on 9/6/15.
//  Copyright (c) 2015 Calvin Gonçalves de Aquino. All rights reserved.
//

#import "CoreDataController.h"
#import "Article.h"
#import "Image.h"

@implementation CoreDataController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (CoreDataController *)sharedInstance {
    static dispatch_once_t onceToken;
    static CoreDataController *_sharedInstance;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        if (!_sharedInstance) {
            _sharedInstance = [[CoreDataController alloc] init];
        }
    });
    return _sharedInstance;
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "cga.newsApp" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"newsApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"newsApp.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}


#pragma mark - Public Methods

+ (NSManagedObjectContext *)context {
    return [CoreDataController sharedInstance].managedObjectContext;
}

+ (void)saveContext {
    [[CoreDataController sharedInstance] saveContext];
}

+ (Article *)newArticle {
    return [Article insertInManagedObjectContext:[CoreDataController context]];
}

+ (Image *)newImage {
    return [Image insertInManagedObjectContext:[CoreDataController context]];
}


+ (NSArray *)allArticles {
    return [CoreDataController findRecordsEntityNamed:[Article entityName] usingPredicate:nil];
}

+ (NSUInteger)countAllArticles {
    return [CoreDataController countRecordsOfClass:[Article class] usingPredicate:nil];
}

+ (Article *)articleWithTitle:(NSString *)title {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@",title];
    return [[CoreDataController findRecordsEntityNamed:[Article entityName] usingPredicate:predicate] firstObject];
}


#pragma mark - Generic Methods

+ (NSArray *)findRecordsEntityNamed:(NSString *)entityName usingPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [CoreDataController context];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [request setEntity:entity];
    [request setResultType:NSManagedObjectResultType];
    
    if (predicate) {
        [request setPredicate:predicate];
    }
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Unresolved fetch error %@, %@", error, [error userInfo]);
    }
    return fetchedObjects;
}

+ (NSUInteger)countRecordsOfClass:(Class)class usingPredicate:(NSPredicate *)predicate {
    NSString *className = NSStringFromClass(class);
    NSManagedObjectContext *context = [CoreDataController context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:context];
    [request setEntity:entity];
    [request setResultType:NSManagedObjectResultType];
    
    if (predicate) {
        [request setPredicate:predicate];
    }
    
    NSError *error = nil;
    NSUInteger objectCount = [context countForFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Unresolved fetch error %@, %@", [error userInfo], error);
    }
    return objectCount;
}


#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
