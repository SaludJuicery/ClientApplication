//
//  UpdateMenuController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/4/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "UpdateMenuController.h"
#import <QuartzCore/QuartzCore.h>
#import "BorderglobalStyle.h"

@implementation UpdateMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //Show Menu Category Item List
    self.autocompleteData1 = [[NSArray alloc] initWithObjects:@"Smoothies",@"Juices",@"Hot Shots",@"Hot Beverages",@"Add ons", nil];
    _catList.delegate=self;
    _catList.dataSource=self;
    [self.view addSubview:_catList];
    _itemList.hidden=YES;
    
    //Below style is for Item Description
    //_itemDesc.layer.cornerRadius=8.0f;
    //BorderGlobalStyle *style = [[BorderGlobalStyle alloc] init];

    //[style setBorderForColor:[UIColor redColor] width:1.0f radius:8.0f ];

    // _itemDesc.layer.masksToBounds=YES;
   //_itemDesc.layer.borderColor=[[UIColor blackColor]CGColor];
   // _itemDesc.layer.borderWidth= 1.0f;
   
    //Below border style for item ingredients
    //_itemDesc.layer.cornerRadius=8.0f;
    //_itemIngre.layer.masksToBounds=YES;
   // _itemIngre.layer.borderColor=[[UIColor blackColor]CGColor];
   // _itemIngre.layer.borderWidth= 1.0f;
    
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
        if([tableView isEqual:_catList])
        {
            return [self.autocompleteData1 count];
        }
        else
        {
            return [self.itemArray count];
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *CategoryListIdentifier = @"CategoryListIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:CategoryListIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryListIdentifier];
    }
   if([tableView isEqual:_catList])
        cell.textLabel.text = [self.autocompleteData1 objectAtIndex:indexPath.row];
    else
        cell.textLabel.text = [self.itemArray objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Use the below code to pass the selecte tableview cell text to
    //Textfield or button or any object
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

    if([tableView isEqual:_catList])
    {
        _itemText.text = selectedCell.textLabel.text;
    }
    else
    {
        _TempStr =selectedCell.textLabel.text;
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    UpdateMenuController *destViewController = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"sw_upmenu"]) {
        destViewController.itemName.text =_TempStr;
    }
}

- (IBAction)showItems:(id)sender {
   
    //Loop the menu items retrieved from the json file to itemarray using
    //[self.itemArray addObject:@""];
    
    self.itemArray = [[NSArray alloc] initWithObjects:@"Item1",@"Item2",@"Item3",@"Item4",@"Item5", nil];
    
    //Use the below code to pass the data to tableview during runtime
    _itemList.delegate = self;
    _itemList.dataSource = self;
    
    _itemList.scrollEnabled = YES;
    _itemList.hidden = NO;
    
    //Reload the tableview to add updated data
    [self.itemList reloadData];
    
    
}

- (IBAction)UpdateMenu:(id)sender {
    
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"\\d{1,2}(\\.\\d{1,2})?" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSTextCheckingResult *match = [regExp firstMatchInString:_itemPrice.text options:0 range:NSMakeRange(0, [_itemPrice.text length])];
    //NSString *menuData;
    
    if ([_itemCat.text isEqualToString:@""])
    {
        [self displayMsg:@"Item Category: Field cannot be empty."];
        [_itemCat becomeFirstResponder];
    }
    else if([_itemName.text isEqualToString:@""]){
        [self displayMsg:@"Item Name: Field cannot be empty."];
        [_itemName becomeFirstResponder];
    }
    else if([_itemDesc.text isEqualToString:@""]){
        [self displayMsg:@"Item Description: Field cannot be empty."];
        [_itemDesc becomeFirstResponder];
    }
    else if([_itemIngre.text isEqualToString:@""]){
        [self displayMsg:@"Item Ingredients: Field cannot be empty."];
        [_itemIngre becomeFirstResponder];
    }
    else if(!match){
        [self displayMsg:@"Item Price: Please enter only numbers.Ex. 99.99"];
        [_itemPrice becomeFirstResponder];
    }
    else{
        
        NSString *name = _itemName.text;
        NSString *cate = _itemCat.text;
        NSString *desc = _itemDesc.text;
        NSString *ingre = _itemIngre.text;
        NSString *price = _itemPrice.text;
        
        NSDictionary *jsonMenu = [NSDictionary dictionaryWithObjectsAndKeys:
                                  name, @"name",
                                  cate, @"cate",
                                  desc, @"desc",
                                  ingre, @"ingre",
                                  price, @"price",nil];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonMenu options:NSJSONWritingPrettyPrinted error:&error];
        NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [self displayMsg:@"Menu Updated Successfully"];
        NSLog(@"menu:%@", result);
    }
}

- (IBAction)Clear:(id)sender {
        int i;
        
        for(i=1;i<=5;i++)
        {
            UITextField *textField=(UITextField *)[self.view viewWithTag:i];
            [textField setText:@""];
        }
}

//Display Error Message
-(void)displayMsg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error Message"
                          message:[NSString stringWithFormat:@"%@",msg]
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];

}

@end
