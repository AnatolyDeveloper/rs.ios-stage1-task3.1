#import "ViewController.h"
@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) UILabel *labelResultColor;
@property (weak, nonatomic) UIView *viewResultColor;

@property (weak, nonatomic) UILabel *labelRed;
@property (weak, nonatomic) UILabel *labelGreen;
@property (weak, nonatomic) UILabel *labelBlue;

@property (weak, nonatomic) UITextField *redTextField;
@property (weak, nonatomic) UITextField *greenTextField;
@property (weak, nonatomic) UITextField *blueTextField;

@property (weak, nonatomic) UIButton *buttonProcess;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.redTextField.delegate = self;
    self.greenTextField.delegate = self;
    self.blueTextField.delegate = self;
    
}

- (void)buttonProcessTapped:(UIButton *)sender {
    //  check isEmpty
    if (self.redTextField.text.length == 0 ||
        self.greenTextField.text.length == 0 ||
        self.blueTextField.text.length == 0) {
        
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor grayColor];
        self.redTextField.text = self.greenTextField.text = self.blueTextField.text = @"";
        [self.view endEditing:YES];
        return;
    }
    //  check isNumber
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([self.redTextField.text rangeOfCharacterFromSet:notDigits].location != NSNotFound ||
        [self.greenTextField.text rangeOfCharacterFromSet:notDigits].location != NSNotFound ||
        [self.blueTextField.text rangeOfCharacterFromSet:notDigits].location != NSNotFound) {
        
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor grayColor];
        self.redTextField.text = self.greenTextField.text = self.blueTextField.text = @"";
        [self.view endEditing:YES];
        return;
    }
    int red = self.redTextField.text.intValue;
    int green = self.greenTextField.text.intValue;
    int blue = self.blueTextField.text.intValue;
    
    // check range
    if (red < 0 || red > 255 || green < 0 || green > 255 || blue < 0 || blue > 255) {
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor grayColor];
        self.redTextField.text = self.greenTextField.text = self.blueTextField.text = @"";
        [self.view endEditing:YES];
        return;
    }
    
    NSMutableString *colorHex = [[[NSMutableString alloc] init] autorelease];
    
    
    red < 16 ? [colorHex appendFormat:@"0x0%X", red] : [colorHex appendFormat:@"0x%X", red];
    green < 16 ? [colorHex appendFormat:@"0%X", green] : [colorHex appendFormat:@"%X", green];
    blue < 16 ? [colorHex appendFormat:@"0%X", blue] : [colorHex appendFormat:@"%X", blue];
    
    self.labelResultColor.text = colorHex;
    self.viewResultColor.backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    
    self.redTextField.text = self.greenTextField.text = self.blueTextField.text = @"";
    [self.view endEditing:YES];
}


// MARK: - Setup UI

- (void)setupUI {
    self.labelResultColor = [[[UILabel alloc] initWithFrame:CGRectMake(20, 80, 100, 40)] autorelease];
    self.labelResultColor.text = @"Color";
    
    self.viewResultColor = [[[UIView alloc]
                             initWithFrame:CGRectMake(self.labelResultColor.frame.origin.x + self.labelResultColor.bounds.size.width + 20,
                                                      self.labelResultColor.frame.origin.y,
                                                      200,
                                                      self.labelResultColor.bounds.size.height)] autorelease];
    self.viewResultColor.backgroundColor = [UIColor grayColor];
    
    self.labelRed = [[[UILabel alloc] initWithFrame:CGRectMake(self.labelResultColor.frame.origin.x,
                                                               self.labelResultColor.frame.origin.y + self.labelResultColor.bounds.size.height + 20,
                                                               70,
                                                               30)] autorelease];
    self.labelRed.text = @"RED";
    
    self.redTextField = [[[UITextField alloc] initWithFrame:CGRectMake(self.labelRed.frame.origin.x + self.labelRed.bounds.size.width + 20,
                                                                       self.labelRed.frame.origin.y,
                                                                       230,
                                                                       self.labelRed.bounds.size.height)] autorelease];
    self.redTextField.placeholder = @"0..255";
    self.redTextField.layer.borderWidth = 1.0;
    self.redTextField.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.redTextField.layer.cornerRadius = 5.0;
    self.redTextField.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.labelRed.bounds.size.height)] autorelease];
    self.redTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    self.labelGreen = [[[UILabel alloc] initWithFrame:CGRectMake(self.labelRed.frame.origin.x,
                                                                 self.labelRed.frame.origin.y + self.labelRed.bounds.size.height + 20,
                                                                 self.labelRed.bounds.size.width,
                                                                 self.labelRed.bounds.size.height)] autorelease];
    self.labelGreen.text = @"GREEN";
    
    self.greenTextField = [[[UITextField alloc] initWithFrame:CGRectMake(self.labelGreen.frame.origin.x + self.labelGreen.bounds.size.width + 20,
                                                                         self.labelGreen.frame.origin.y,
                                                                         self.redTextField.bounds.size.width,
                                                                         self.labelGreen.bounds.size.height)] autorelease];
    self.greenTextField.placeholder = @"0..255";
    self.greenTextField.layer.borderWidth = 1.0;
    self.greenTextField.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.greenTextField.layer.cornerRadius = 5.0;
    self.greenTextField.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.labelGreen.bounds.size.height)] autorelease];
    self.greenTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    self.labelBlue = [[[UILabel alloc] initWithFrame:CGRectMake(self.labelGreen.frame.origin.x,
                                                                self.labelGreen.frame.origin.y + self.labelGreen.bounds.size.height + 20,
                                                                self.labelGreen.bounds.size.width,
                                                                self.labelGreen.bounds.size.height)] autorelease];
    self.labelBlue.text = @"BLUE";
    
    self.blueTextField = [[[UITextField alloc] initWithFrame:CGRectMake(self.labelBlue.frame.origin.x + self.labelGreen.bounds.size.width + 20,
                                                                        self.labelBlue.frame.origin.y,
                                                                        self.redTextField.bounds.size.width,
                                                                        self.labelBlue.bounds.size.height)] autorelease];
    self.blueTextField.placeholder = @"0..255";
    self.blueTextField.layer.borderWidth = 1.0;
    self.blueTextField.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.blueTextField.layer.cornerRadius = 5.0;
    self.blueTextField.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.labelBlue.bounds.size.height)] autorelease];
    self.blueTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    self.buttonProcess = [[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 50,
                                                                     self.labelBlue.frame.origin.y + self.labelBlue.bounds.size.height + 40,
                                                                     100,
                                                                     30)] autorelease];
    //  setuo buttonProcess
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess setTitleColor: UIColor.blueColor forState: UIControlStateNormal];
    [self.buttonProcess setTitleColor: UIColor.grayColor forState: UIControlStateHighlighted];
    //  add tarrget and selection for event
    [self.buttonProcess addTarget:self
                           action:@selector(buttonProcessTapped:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    //  accessibilityIdentifiers
    self.view.accessibilityIdentifier = @"mainView";
    
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
    
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.redTextField.accessibilityIdentifier = @"textFieldRed";
    
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.greenTextField.accessibilityIdentifier = @"textFieldGreen";
    
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.blueTextField.accessibilityIdentifier = @"textFieldBlue";
    
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    
    //  addSubviews
    [self.view addSubview:self.labelResultColor];
    [self.view addSubview:self.viewResultColor];
    
    [self.view addSubview:self.labelRed];
    [self.view addSubview:self.redTextField];
    
    [self.view addSubview:self.labelGreen];
    [self.view addSubview:self.greenTextField];
    
    [self.view addSubview:self.labelBlue];
    [self.view addSubview:self.blueTextField];
    
    [self.view addSubview:self.buttonProcess];
}

// MARK: - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.labelResultColor.text = @"Color";
    
}

@end
