// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Article.m instead.

#import "_Article.h"

const struct ArticleAttributes ArticleAttributes = {
	.authors = @"authors",
	.content = @"content",
	.date = @"date",
	.image = @"image",
	.title = @"title",
	.website = @"website",
};

@implementation ArticleID
@end

@implementation _Article

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Article";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Article" inManagedObjectContext:moc_];
}

- (ArticleID*)objectID {
	return (ArticleID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic authors;

@dynamic content;

@dynamic date;

@dynamic image;

@dynamic title;

@dynamic website;

@end

