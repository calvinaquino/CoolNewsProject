// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Image.h instead.

#import <CoreData/CoreData.h>

extern const struct ImageAttributes {
	__unsafe_unretained NSString *fetched;
	__unsafe_unretained NSString *filePath;
	__unsafe_unretained NSString *url;
} ImageAttributes;

extern const struct ImageRelationships {
	__unsafe_unretained NSString *article;
} ImageRelationships;

@class Article;

@interface ImageID : NSManagedObjectID {}
@end

@interface _Image : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ImageID* objectID;

@property (nonatomic, strong) NSNumber* fetched;

@property (atomic) BOOL fetchedValue;
- (BOOL)fetchedValue;
- (void)setFetchedValue:(BOOL)value_;

//- (BOOL)validateFetched:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* filePath;

//- (BOOL)validateFilePath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Article *article;

//- (BOOL)validateArticle:(id*)value_ error:(NSError**)error_;

@end

@interface _Image (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveFetched;
- (void)setPrimitiveFetched:(NSNumber*)value;

- (BOOL)primitiveFetchedValue;
- (void)setPrimitiveFetchedValue:(BOOL)value_;

- (NSString*)primitiveFilePath;
- (void)setPrimitiveFilePath:(NSString*)value;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

- (Article*)primitiveArticle;
- (void)setPrimitiveArticle:(Article*)value;

@end
