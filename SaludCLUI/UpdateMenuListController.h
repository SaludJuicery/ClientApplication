//
//  UpdateMenuListController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/18/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "MessageController.h"

@interface UpdateMenuListController : UIViewController <UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>
{
    UIView *viewFooter;
    MessageController *msg;
}

@property (strong,nonatomic) DownPicker *downPickerCat;
@property (weak, nonatomic) IBOutlet UITextField *txtFldCategory;
@property (weak, nonatomic) IBOutlet UITableView *tblViewCategories;
@property (strong,nonatomic) NSMutableArray *itemsArray;
@property (weak, nonatomic) NSString *menuItem;
@property (weak, nonatomic) NSString *catName;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
- (IBAction)showUpdateItem:(id)sender;


//-(void)getCategories:(id) sender;
-(void)getMenuItems:(id) sender;
-(void)showItems:(id)sender;


@end
