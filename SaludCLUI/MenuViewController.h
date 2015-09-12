//
//  MenuViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/20/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    IBOutlet UITextField *category;
    NSMutableArray *pastCategory;
    NSMutableArray *autocompleteData;
    UITableView *autocompleteTableView;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (nonatomic, retain) UITextField *category;
@property (nonatomic, retain) NSMutableArray *pastCategory;
@property (nonatomic, retain) NSMutableArray *autocompleteData;
@property (nonatomic, retain) IBOutlet UITableView *autocompleteTableView;

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;

- (IBAction)addNewCategory:(id)sender;

@end