#import "Article.h"

@interface Article ()

@end

@implementation Article

- (void)populateWithDictionary:(NSDictionary *)dictionary {
    self.title = dictionary[ArticleAttributes.title];
    self.website = dictionary[ArticleAttributes.website];
    self.date = dictionary[ArticleAttributes.date];
    self.authors = dictionary[ArticleAttributes.authors];
    self.content = dictionary[ArticleAttributes.content];
    
    if (![[dictionary[ArticleAttributes.image] class] isSubclassOfClass:[NSNull class]]) {
        self.image = dictionary[ArticleAttributes.image];
    }
}

@end
