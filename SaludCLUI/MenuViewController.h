//
//  MenuViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/20/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageController.h"

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray *pastCategory;
    NSMutableArray *autocompleteData;
    UITableView *autocompleteTableView;
    MessageController *msg;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnMenu;

@property (nonatomic, retain) NSMutableArray *pastCategory;
@property (nonatomic, retain) NSMutableArray *autocompleteData;


- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;

@end
