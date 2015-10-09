//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Sean Kemper on 10/8/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"defaultTipSelection"]) {
        self.defaultTipControl.selectedSegmentIndex = [defaults integerForKey:@"defaultTipSelection"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeDefault:(UISegmentedControl *)sender {
    NSInteger selected = self.defaultTipControl.selectedSegmentIndex;
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:selected forKey:@"defaultTipSelection"];
    [defaults synchronize];
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
