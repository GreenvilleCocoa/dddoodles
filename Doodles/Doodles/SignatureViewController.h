
#import <UIKit/UIKit.h>
#import "SignatureView.h"

@interface SignatureViewController : UIViewController <SignatureViewDelegate>

typedef void (^SignatureCompletion)(Signature *signature);

@property (nonatomic, strong) Signature *signature;
@property (nonatomic, copy) SignatureCompletion completion;

@end

