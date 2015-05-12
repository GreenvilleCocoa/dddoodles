
#import "SignatureView.h"

@interface SignatureView()

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@property (nonatomic, readwrite) CGPoint lastPoint;

@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation SignatureView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addGestureRecognizer:self.panRecognizer];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self.lineColor setStroke];
    [self.path stroke];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint currentPoint = [pan locationInView:self];
    CGPoint midPoint = CGPointMake((currentPoint.x + self.lastPoint.x) / 2, (currentPoint.y + self.lastPoint.y) / 2);
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        if (self.path.isEmpty) {
            [self.delegate signingBeganInSignatureView:self];
        }
        
        [self.path moveToPoint:currentPoint];
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.path addQuadCurveToPoint:midPoint controlPoint:self.lastPoint];
    }
    
    [self setLastPoint:currentPoint];
    
    [self setNeedsDisplay];
}

- (void)clear
{
    [self setPath:nil];
    [self setNeedsDisplay];
}

#pragma mark - Properties

- (UIPanGestureRecognizer *)panRecognizer
{
    if (!_panRecognizer) {
        _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [_panRecognizer setMaximumNumberOfTouches:1];
        [_panRecognizer setMinimumNumberOfTouches:1];
    }
    
    return _panRecognizer;
}

- (UIBezierPath *)path
{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
        [_path setLineWidth:2.5];
    }
    
    return _path;
}

- (UIColor *)lineColor
{
    if (!_lineColor) {
        _lineColor = [UIColor blackColor];
    }
    
    return _lineColor;
}

@end
