// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Article.m instead.

#import "_Article.h"

const struct ArticleAttributes ArticleAttributes = {
	.authors = @"authors",
	.content = @"content",
	.date = @"date",
	.image = @"image",
	.read = @"read",
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

	if ([key isEqualToString:@"readValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"read"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic authors;

@dynamic content;

@dynamic date;

@dynamic image;

@dynamic read;

- (BOOL)readValue {
	NSNumber *result = [self read];
	return [result boolValue];
}

- (void)setReadValue:(BOOL)value_ {
	[self setRead:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveReadValue {
	NSNumber *result = [self primitiveRead];
	return [result boolValue];
}

- (void)setPrimitiveReadValue:(BOOL)value_ {
	[self setPrimitiveRead:[NSNumber numberWithBool:value_]];
}

@dynamic title;

@dynamic website;

@end

