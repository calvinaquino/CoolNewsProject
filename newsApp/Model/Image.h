#import "_Image.h"

@class UIImage;

@interface Image : _Image {}

- (void)fetchImageIfNeededWithCompletion:(void (^)(UIImage *))completionBlock;
- (void)deleteImageFile;

- (UIImage *)imageFromDisk;

+ (void)saveImageData:(NSData *)imageData forImage:(Image *)image;

@end
