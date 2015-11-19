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
    UIView *footerView;
    MessageController *msg;
}

@property (strong,nonatomic) DownPicker *downPickerCat;
@property (weak, nonatomic) IBOutlet UITextField *itemText;
@property (weak, nonatomic) IBOutlet UITableView *itemListView;
@property (strong,nonatomic) NSMutableArray *itemsArray;
@property (weak, nonatomic) NSString *menuItem;
@property (weak, nonatomic) NSString *catName;

//-(void)getCategories:(id) sender;
-(void)getMenuItems:(id) sender;
-(void)showItems:(id)sender;


@end
