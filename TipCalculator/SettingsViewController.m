//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Sean Kemper on 10/8/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "SettingsViewController.h"

#define lightColor [UIColor colorWithRed:133.0/255 green:175.0/255 blue:199.0/255 alpha:1];
#define darkColor [UIColor colorWithRed:0 green:62.0/255 blue:85.0/255 alpha:1];

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *defaultTipLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property (weak, nonatomic) IBOutlet UILabel *invertLabel;
@property (weak, nonatomic) IBOutlet UISwitch *invertSwitch;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"defaultTipSelection"]) {
        self.defaultTipControl.selectedSegmentIndex = [defaults integerForKey:@"defaultTipSelection"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"invertColors"]) {
        [self setDarkColorScheme];
        self.invertSwitch.on = true;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)invertColors:(UISwitch *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.invertSwitch.on) {
        [self setDarkColorScheme];
        [defaults setBool:true forKey:@"invertColors"];
    } else {
        [self setLightColorScheme];
        [defaults setBool:false forKey:@"invertColors"];
    }
    [defaults synchronize];
}

- (IBAction)changeDefault:(UISegmentedControl *)sender {
    NSInteger selected = self.defaultTipControl.selectedSegmentIndex;
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:selected forKey:@"defaultTipSelection"];
    [defaults synchronize];
}

- (void)setLightColorScheme {
    NSLog(@"set light");
    self.defaultTipLabel.textColor = darkColor;
    self.defaultTipControl.tintColor = darkColor;
    self.invertLabel.textColor = darkColor;
    self.invertSwitch.tintColor = darkColor;
    self.view.backgroundColor = lightColor;
}

- (void)setDarkColorScheme {
    NSLog(@"set dark");
    self.defaultTipLabel.textColor = lightColor;
    self.defaultTipControl.tintColor = lightColor;
    self.invertLabel.textColor = lightColor;
    self.invertSwitch.tintColor = lightColor;
    self.view.backgroundColor = darkColor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
