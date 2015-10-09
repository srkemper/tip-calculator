//
//  ViewController.m
//  TipCalculator
//
//  Created by Sean Kemper on 10/8/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "TipViewController.h"

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

@end
