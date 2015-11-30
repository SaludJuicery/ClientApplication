//
//  NewsLetterViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/20/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "NewsLetterViewController.h"
#import "SWRevealViewController.h"
#import <MessageUI/MessageUI.h>
#import "MessageController.h"
#import "GetUrl.h"
#import "RemoteGetData.h"
#import "Reachability.h"

@interface NewsLetterViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation NewsLetterViewController
@synthesize tblViewRecipients,senderList,txtFldSubject,txtViewMessage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    txtFldSubject.borderStyle = UITextBorderStyleRoundedRect;

    self.txtViewMessage.layer.cornerRadius = 5;
    self.txtViewMessage.layer.borderWidth = 0.5f;
    self.txtViewMessage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    _btnMenu.target=self.revealViewController;
    _btnMenu.action=@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    self.senderList = [[NSMutableArray alloc] initWithObjects:@"viek@gmail.com",@"yuan@gmail.com",@"vignesh@gmail.com",@"keerthi@yahoo.com", nil];
    tblViewRecipients.delegate = self;
    tblViewRecipients.dataSource = self;
    [tblViewRecipients setEditing:YES animated:YES];
    [self.view addSubview:tblViewRecipients];

}

- (IBAction)sendMail:(UIButton *)sender
{
    MessageController *msg = [[MessageController  alloc] init];
    
        NSArray *selectedCells = [self.tblViewRecipients indexPathsForSelectedRows];
    
        if([txtFldSubject.text isEqualToString:@""])
        {
            [msg displayMessage:@"Please enter a subject..."];
        }
        else if([txtViewMessage.text isEqualToString:@""])
        {
            [msg displayMessage:@"Please enter a message..."];
        }
        else if(selectedCells.count > 0)
        {
            UIAlertView *mailConfirm = [[UIAlertView alloc]
                                          initWithTitle:@"Mail Confirmation"
                                          message:@"Please confirm to send mail?"
                                          delegate:self
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"YES", nil];
            
            [mailConfirm show];
        }
        else
        {
            [msg displayMessage:@"Please select a reciepient..."];
        }

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"YES"])
    {
        
        MessageController *msg = [[MessageController alloc]init];
        
        NSArray *selectedList = [self.tblViewRecipients indexPathsForSelectedRows];
        
        NSMutableIndexSet *indicesToDelete  = [[NSMutableIndexSet alloc] init];
        
        //Store selected Cells value in an array
        NSMutableArray *listToSend = [[NSMutableArray alloc] init];
        
        //Get the indexs from the array to delete items
        for (NSIndexPath *indexPath in selectedList) {
            [indicesToDelete addIndex:indexPath.row];
            [listToSend addObject:[senderList objectAtIndex:indexPath.row]];
        }
        
        //Below code checks whether internet connection is there or not
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        msg = [[MessageController alloc] init];
        
        if (networkStatus == NotReachable) {
            [msg displayMessage:@"No internet connection..Please connect to the internet.."];
        }
        else
        {
            if ([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
                mail.mailComposeDelegate = self;
                [mail setSubject:txtFldSubject.text];
                [mail setMessageBody:txtViewMessage.text isHTML:NO];
                [mail setToRecipients:listToSend];
                
                //[mail setToRecipients:@[@"testingEmail@example.com"]];
                
                //[self presentViewController:mail animated:YES completion:NULL];
            }
            else
            {
                NSLog(@"This device cannot send email");
            }
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"Mail has been sent.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail has been saved.");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"Mail has been cancelled.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email:%@", [error localizedDescription]);
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email: %@",[error localizedDescription]);
            break;
    }
    
    //[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    
    return senderList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    cell.textLabel.text = [senderList objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    //urlField.text = selectedCell.textLabel.text;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)clearFields:(UIButton *)sender {
    txtFldSubject.text=@"";
    txtViewMessage.text=@"";
    [tblViewRecipients reloadData];
}
@end
