//
//  RewardsViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/28/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "RewardsViewController.h"
#import "SWRevealViewController.h"

@interface RewardsViewController ()

@end

@implementation RewardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
        _rewardsButton.target=self.revealViewController;
        _rewardsButton.action=@selector(revealToggle:);
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    

}

/*-(void)viewMenu{
[self performSegueWithIdentifier:@"showMenuSegue" sender: self];
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applicationFinishedRestoringState
{
   /* SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        _rewardsButton.target=self.revealViewController;
        _rewardsButton.action=@selector(revealToggle:);
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }*/
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
