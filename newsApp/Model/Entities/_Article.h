// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Article.h instead.

#import <CoreData/CoreData.h>

extern const struct ArticleAttributes {
	__unsafe_unretained NSString *authors;
	__unsafe_unretained NSString *content;
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *read;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *website;
} ArticleAttributes;

extern const struct ArticleRelationships {
	__unsafe_unretained NSString *image;
} ArticleRelationships;

@class Image;

@interface ArticleID : NSManagedObjectID {}
@end

@interface _Article : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ArticleID* objectID;

@property (nonatomic, strong) NSString* authors;

//- (BOOL)validateAuthors:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* content;

//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* read;

@property (atomic) BOOL readValue;
- (BOOL)readValue;
- (void)setReadValue:(BOOL)value_;

//- (BOOL)validateRead:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* website;

//- (BOOL)validateWebsite:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Image *image;

//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;

@end

@interface _Article (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthors;
- (void)setPrimitiveAuthors:(NSString*)value;

- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;

- (NSString*)primitiveDate;
- (void)setPrimitiveDate:(NSString*)value;

- (NSNumber*)primitiveRead;
- (void)setPrimitiveRead:(NSNumber*)value;

- (BOOL)primitiveReadValue;
- (void)setPrimitiveReadValue:(BOOL)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSString*)primitiveWebsite;
- (void)setPrimitiveWebsite:(NSString*)value;

- (Image*)primitiveImage;
- (void)setPrimitiveImage:(Image*)value;

@end
