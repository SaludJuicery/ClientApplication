//
//  DeleteViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/11/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "MessageController.h"

@interface DeleteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    NSMutableArray *autoCompleteData;
    NSMutableArray *selectedObjects;
    UITableView *tblViewItems;
    UIView *viewFooter;
    MessageController *msg;

}

@property (strong,nonatomic) DownPicker *downPickerCat;
@property (weak, nonatomic) IBOutlet UITextField *txtFldCategory;
@property (nonatomic, retain) NSMutableArray *autoCompleteData;
@property (nonatomic, retain) NSMutableArray *selectedObjects;
@property (nonatomic, retain) IBOutlet UITableView *tblViewItems;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

- (IBAction)deleteItems:(id)sender;

@end
