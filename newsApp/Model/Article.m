#import "Article.h"
#import "Image.h"
#import "CoreDataController.h"
#import "AFNetworking.h"

@interface Article ()

@end

@implementation Article

- (void)populateWithDictionary:(NSDictionary *)dictionary {
    self.title = dictionary[ArticleAttributes.title];
    self.website = dictionary[ArticleAttributes.website];
    self.date = dictionary[ArticleAttributes.date];
    self.authors = dictionary[ArticleAttributes.authors];
    self.content = dictionary[ArticleAttributes.content];
    
    if (![[dictionary[ArticleRelationships.image] class] isSubclassOfClass:[NSNull class]]) {
        self.image = [CoreDataController newImage];
        self.image.url = dictionary[ArticleRelationships.image];
        [CoreDataController saveContext];
    }
}

- (void)deleteImage {
    if (self.image.fetchedValue) {
        [self.image deleteImageFile];
    }
    
    [[CoreDataController context] deleteObject:self.image];
}

@end
