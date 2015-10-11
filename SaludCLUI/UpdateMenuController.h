//
//  UpdateMenuController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/4/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateMenuController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *itemCat;
@property (weak, nonatomic) IBOutlet UITextField *itemName;
@property (weak, nonatomic) IBOutlet UITextField *itemPrice;
@property (weak, nonatomic) IBOutlet UITextView *itemDesc;
@property (weak, nonatomic) IBOutlet UITextView *itemIngre;
@property (weak, nonatomic) IBOutlet UIButton *update;
@property (weak, nonatomic) IBOutlet UIButton *clear;
@property (weak, nonatomic) IBOutlet UITextField *itemText;
@property (strong,nonatomic) NSArray *autocompleteData1;
@property (strong,nonatomic) NSArray *itemArray;
@property (weak, nonatomic) IBOutlet UITableView *itemList;
@property (weak, nonatomic) IBOutlet UITableView *catList;
@property (weak, nonatomic) NSString *TempStr;
@property (weak, nonatomic) IBOutlet UIButton *showItems;

-(void)displayMsg:(NSString*)msg;
- (IBAction)showItems:(id)sender;
- (IBAction)UpdateMenu:(id)sender;
- (IBAction)Clear:(id)sender;

@end
