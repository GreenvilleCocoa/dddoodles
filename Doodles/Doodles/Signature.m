
#import "Signature.h"

@interface Signature()

@end

@implementation Signature

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.path = [aDecoder decodeObjectForKey:@"path"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.path forKey:@"path"];
}

#pragma mark - Properties

- (NSDate *)date
{
    if (!_date) {
        _date = [NSDate date];
    }
    
    return _date;
}

- (UIBezierPath *)path
{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    
    return _path;
}

- (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color
{
    // No Path?
    if (!self.path) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    if (!color) {
        [[UIColor blackColor] setStroke];
    }
    else {
        [color setStroke];
    }
    
    CGFloat expectedSizeInset = 2.0;
    
    // The expected size needs to be inset just a bit to ensure no cutoff
    CGSize expectedSize = CGSizeMake(size.width - expectedSizeInset, size.height - expectedSizeInset);
    
    UIBezierPath *path = self.path.copy;
    
    // reset the origin
    [path applyTransform:CGAffineTransformMakeTranslation(-floorf(CGRectGetMinX(path.bounds)), -floorf(CGRectGetMinY(path.bounds)))];
    
    // Scale the path
    CGFloat widthProportion = expectedSize.width / CGRectGetWidth(path.bounds);
    CGFloat heightProportion = expectedSize.height / CGRectGetHeight(path.bounds);
    CGFloat proportion = MIN(widthProportion, heightProportion);
    [path applyTransform:CGAffineTransformMakeScale(proportion, proportion)];
    
    // Offset for the expected size.
    [path applyTransform:CGAffineTransformMakeTranslation(floorf(expectedSizeInset / 2.0), floorf(expectedSizeInset / 2.0))];
    
    // Bottom Align the Path
    [path applyTransform:CGAffineTransformMakeTranslation(0.0, floorf((expectedSize.height - CGRectGetHeight(path.bounds)) / 2.0))];
    
    
    // Stroke the Path
    [path stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
