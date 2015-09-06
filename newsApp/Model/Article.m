#import "Article.h"

@interface Article ()

@end

@implementation Article

- (void)populateWithDictionary:(NSDictionary *)dictionary {
    self.title = dictionary[ArticleAttributes.title];
    self.website = dictionary[ArticleAttributes.website];
//    self.image = dictionary[ArticleAttributes.image];
    self.date = dictionary[ArticleAttributes.date];
    self.authors = dictionary[ArticleAttributes.authors];
    self.content = dictionary[ArticleAttributes.content];
}

@end
