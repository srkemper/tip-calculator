//
//  ViewController.m
//  TipCalculator
//
//  Created by Sean Kemper on 10/8/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "TipViewController.h"

#define lightColor [UIColor colorWithRed:133.0/255 green:175.0/255 blue:199.0/255 alpha:1];
#define darkColor [UIColor colorWithRed:0 green:62.0/255 blue:85.0/255 alpha:1];

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *equalsLabel;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UIView *dividerLine;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.billTextField becomeFirstResponder];
    self.title = @"Tippy";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"dateLastOpen"]) {
        NSDate *now = [NSDate date];
        NSDate *then = [defaults objectForKey:@"dateLastOpen"];
        NSTimeInterval secondsSinceClose = [then timeIntervalSinceDate:now];
        if (secondsSinceClose < 60 * 10) { //if seconds < 600 (10 minutes)
            self.billTextField.text = [defaults stringForKey:@"billTextField"];
        }
    }
    [self updateValues];
}

- (IBAction)textValueChanged:(UITextField *)sender {
    [self updateValues];
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"defaultTipSelection"]) {
        self.tipControl.selectedSegmentIndex = [defaults integerForKey:@"defaultTipSelection"];
    }
    if ([defaults boolForKey:@"invertColors"]) {
        [self setDarkColorScheme];
    } else {
        [self setLightColorScheme];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onValueChanged:(UISegmentedControl *)sender {
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValues = @[@(0.15), @(0.2), @(0.25)];
    float tipAmount = [tipValues[self.tipControl.selectedSegmentIndex] floatValue] * billAmount;
    float totalAmount = billAmount + tipAmount;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    self.tipLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:tipAmount]];
    self.totalLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:totalAmount]];
//    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
//    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSDate *date = [NSDate date];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:date forKey:@"dateLastOpen"];
    [defaults setObject:self.billTextField.text forKey:@"billTextField"];
    [defaults synchronize];
}

- (void)setLightColorScheme {
    self.billTextField.textColor = darkColor;
    self.billTextField.tintColor = darkColor;
    self.dividerLine.backgroundColor = darkColor;
    self.plusLabel.textColor = darkColor;
    self.equalsLabel.textColor = darkColor;
    self.tipLabel.textColor = darkColor;
    self.totalLabel.textColor = darkColor;
    self.tipControl.tintColor = darkColor;
    self.view.backgroundColor = lightColor;
}

- (void)setDarkColorScheme {
    self.billTextField.textColor = lightColor;
    self.billTextField.tintColor = lightColor;
    self.dividerLine.backgroundColor = lightColor;
    self.plusLabel.textColor = lightColor;
    self.equalsLabel.textColor = lightColor;
    self.tipLabel.textColor = lightColor;
    self.totalLabel.textColor = lightColor;
    self.tipControl.tintColor = lightColor;
    self.view.backgroundColor = darkColor;
}

@end
