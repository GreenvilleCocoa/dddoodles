
#import "SignatureViewController.h"

NSString * const doneButtonText = @"Done";
NSString * const cancelButtonCancelText = @"Cancel";
NSString * const cancelButtonClearText = @"Clear";

@interface SignatureViewController ()

@property (nonatomic, strong) SignatureView *signatureView;

@property (nonatomic, strong) UIBarButtonItem *cancelButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;

@property (nonatomic, strong) UIView *placeholderLine;

@property (nonatomic, readwrite) BOOL presenting;

@end

@implementation SignatureViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self initWithCompletion:nil];
    }
    return self;
}

- (instancetype)initWithCompletion:(void (^)(Signature *signature))completion
{
    self = [super init];
    if (self) {
        [self setCompletion:completion];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.signatureView];
    
    [self.signatureView setDelegate:self];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem = self.cancelButton;
    self.navigationItem.rightBarButtonItem = self.doneButton;
    
    [self setupConstraints];
}

- (void)setupConstraints
{
    NSDictionary *views = @{@"signatureView" : self.signatureView,
                            };
  
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[signatureView]|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[signatureView]|" options:0 metrics:nil views:views]];
}

- (void)finish
{
    //save signature
    [self.signature setPath:self.signatureView.path];
    
    if (self.completion) {
        self.completion(self.signature);
    }
}

#pragma mark - Button actions

- (void)cancelPressed
{
    if (!self.signaturePath.isEmpty) {
        [self.signatureView clear];
        
        [self.cancelButton setTitle:cancelButtonCancelText];
        
        [self.doneButton setEnabled:NO];
    }
    else {
        [self finish];
    }
}

- (void)donePressed
{
    [self finish];
}

#pragma mark - SignatureViewDelegate

- (void)signingBeganInSignatureView:(SignatureView *)signatureView
{
    [self.cancelButton setTitle:cancelButtonClearText];
    
    [self.doneButton setEnabled:YES];
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    self.presenting = NO;
}

#pragma mark - Properties

- (UIBezierPath *)signaturePath
{
    return self.signatureView.path;
}

- (Signature *)signature
{
    if (!_signature) {
        _signature = [[Signature alloc] init];
    }

    return _signature;
}

#pragma mark - Views

- (SignatureView *)signatureView
{
    if (!_signatureView) {
        _signatureView = [[SignatureView alloc] init];
        
        [_signatureView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    return _signatureView;
}

- (UIBarButtonItem *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIBarButtonItem alloc] initWithTitle:cancelButtonCancelText style:UIBarButtonItemStylePlain target:self action:@selector(cancelPressed)];
    }
    
    return _cancelButton;
}

- (UIBarButtonItem *)doneButton
{
    if (!_doneButton) {
        _doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)];
       
        [_doneButton setEnabled:NO];
        
        [_doneButton setTitle:doneButtonText];
    }
    
    return _doneButton;
}

@end
