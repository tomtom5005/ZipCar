//
//  ViewController.m
//  ZipCar
//
//  Created by Thomas Thompson on 7/28/15.
//  Copyright (c) 2015 Thomas Thompson. All rights reserved.
//

#import "ViewController.h"
#import "RomanNumeral.h"
//#import "ZipCar-Swift.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *romanNumeralTextField;
@property (strong, nonatomic) IBOutlet UILabel *decimalValue;
@property (strong, nonatomic) RomanNumeral *romanNumeral;
@property (weak, nonatomic) IBOutlet UILabel *decimalValueLabel;

@end

static NSString  *const DecimalValue = @"Decimal Value :";
static NSString  *const InvalidRomanNumeral = @"Invalid Numeral :";
static NSString  *const UnknownValue = @"?????";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.romanNumeral = [[RomanNumeral alloc] initWithString:@""];
    [self.romanNumeralTextField addTarget:self
                                   action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    [self reloadView];
}

- (void) textFieldDidChange:(UITextField *)textField{
    self.romanNumeral.string = [textField.text uppercaseString];
    [self reloadView];
}

-(void)reloadView{
    UIColor *textColor;
    NSInteger value  =  self.romanNumeral.numericValue;
    if(value == ZCInvalidRomanNumeral){
        textColor =  [UIColor redColor];
        self.decimalValueLabel.text = InvalidRomanNumeral;
        self.decimalValue.text = UnknownValue;
        
    }
    else{
        textColor =  [UIColor blackColor];
        self.decimalValueLabel.text = DecimalValue;
        self.decimalValue.text = value > 0 ? [NSString stringWithFormat:@"%ld",(long)value] : @"";
    }
    self.decimalValueLabel.textColor = textColor;
    self.decimalValue.textColor = textColor;
    self.romanNumeralTextField.textColor = textColor;
    self.romanNumeralTextField.text = [self.romanNumeralTextField.text uppercaseString];
}
@end

