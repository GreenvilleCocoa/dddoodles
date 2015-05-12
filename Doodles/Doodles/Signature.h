
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Signature : NSObject <NSCoding>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UIBezierPath *path;

- (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color;

@end
