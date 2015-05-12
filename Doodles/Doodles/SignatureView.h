
#import <UIKit/UIKit.h>
#import "Signature.h"

@class SignatureView;

@protocol SignatureViewDelegate <NSObject>

@required

- (void)signingBeganInSignatureView:(SignatureView *)signatureView;

@end

@interface SignatureView : UIView

@property (nonatomic, weak) id<SignatureViewDelegate> delegate;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIBezierPath *path;

- (void)clear;

@end


