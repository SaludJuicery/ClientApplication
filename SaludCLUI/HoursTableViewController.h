//
//  HoursTableViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/13/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "MessageController.h"

@interface HoursTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    MessageController *msg;
    UIView *footerView;
}
@property (strong,nonatomic) DownPicker *downPickerloc;
@property (strong,nonatomic) DownPicker *downPickermon;
@property (strong,nonatomic) DownPicker *downPickertue;
@property (strong,nonatomic) DownPicker *downPickerwed;
@property (strong,nonatomic) DownPicker *downPickerthu;
@property (strong,nonatomic) DownPicker *downPickerfri;
@property (strong,nonatomic) DownPicker *downPickersat;
@property (strong,nonatomic) DownPicker *downPickersun;

@property (weak, nonatomic) IBOutlet UITextField *txtFldLoc;
@property (weak,nonatomic) NSString *locName;
@property (weak, nonatomic) IBOutlet UITextField *mOpen;
@property (weak, nonatomic) IBOutlet UITextField *mClose;
@property (weak, nonatomic) IBOutlet UITextField *mstatus;
@property (weak, nonatomic) IBOutlet UITextField *tuOpen;
@property (weak, nonatomic) IBOutlet UITextField *tuClose;
@property (weak, nonatomic) IBOutlet UITextField *tustatus;
@property (weak, nonatomic) IBOutlet UITextField *wClose;
@property (weak, nonatomic) IBOutlet UITextField *wOpen;
@property (weak, nonatomic) IBOutlet UITextField *wstatus;
@property (weak, nonatomic) IBOutlet UITextField *tOpen;
@property (weak, nonatomic) IBOutlet UITextField *tClose;
@property (weak, nonatomic) IBOutlet UITextField *tstatus;
@property (weak, nonatomic) IBOutlet UITextField *fOpen;
@property (weak, nonatomic) IBOutlet UITextField *fClose;
@property (weak, nonatomic) IBOutlet UITextField *fstatus;
@property (weak, nonatomic) IBOutlet UITextField *satOpen;
@property (weak, nonatomic) IBOutlet UITextField *satClose;
@property (weak, nonatomic) IBOutlet UITextField *satstatus;
@property (weak, nonatomic) IBOutlet UITextField *sunOpen;
@property (weak, nonatomic) IBOutlet UITextField *sunClose;
@property (weak, nonatomic) IBOutlet UITextField *sunstatus;

@property (weak,nonatomic) NSArray *jsonArray;

@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;

- (IBAction)updateHours:(id)sender;


@end
