//
//  NewsLetterViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/20/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsLetterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnMenu;

@property (weak, nonatomic) IBOutlet UITextView *txtViewMessage;

@property (weak, nonatomic) IBOutlet UITableView *tblViewRecipients;

@property (weak, nonatomic) IBOutlet UITextField *txtFldSubject;

@property (weak, nonatomic) IBOutlet UIButton *btnSendMail;

@property (strong,nonatomic) NSMutableArray *senderList;

- (IBAction)sendMail:(UIButton *)sender;
- (IBAction)clearFields:(UIButton *)sender;

@end
