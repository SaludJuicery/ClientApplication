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
    UITableView *autoCompleteView;
}

@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (strong,nonatomic) DownPicker *downPicker;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, retain) NSMutableArray *autoCompleteData;
@property (nonatomic, retain) NSMutableArray *selectedObjects;
@property (nonatomic, retain) IBOutlet UITableView *autoCompleteView;

- (IBAction)deleteItems:(id)sender;

@end
