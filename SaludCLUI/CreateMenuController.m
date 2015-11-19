//
//  CreateMenuController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/13/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "CreateMenuController.h"
#import "RemoteLogin.h"
#import "MessageController.h"
#import "DownPicker.h"
#import "GetUrl.h"
#import "GetCategories.h"
#import "Reachability.h"

@interface CreateMenuController ()

@end

@implementation CreateMenuController
@synthesize categoryList;


- (void)viewDidLoad {
[super viewDidLoad];
    
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {
        GetCategories *getCategory = [[GetCategories alloc] init];
        categoryList = [getCategory getCategories];
    }
    //Get the Categories from db
    self.downPickerCat = [[DownPicker alloc] initWithTextField:_itemCat withData:categoryList];
    
    
// create the array of data for location and bind to location field
NSMutableArray* arrLoc = [[NSMutableArray alloc] init];
[arrLoc addObject:@"ShadySide"];
[arrLoc addObject:@"Sewickley"];
[arrLoc addObject:@"Both"];
self.downPickerLoc = [[DownPicker alloc] initWithTextField:self.location withData:arrLoc];
}


- (void)didReceiveMemoryWarning {
[super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}

/*BElow FUnction is used to clear all the fields in the screen*/
-(void)clearButton:(id)sender
{
int i;

for(i=1;i<=6;i++)
{
UITextField *textField=(UITextField *)[self.view viewWithTag:i];
[textField setText:@""];
}
_itemDesc.text = @"";
}

/*Below function is used to submit the data as entered by the user*/
-(void)submitButton:(id)sender {

NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$" options:NSRegularExpressionCaseInsensitive error:NULL];

NSTextCheckingResult *matchPetite = [regExp firstMatchInString:_petite.text options:0 range:NSMakeRange(0, [_petite.text length])];
NSTextCheckingResult *matchRegular = [regExp firstMatchInString:_regular.text options:0 range:NSMakeRange(0, [_regular.text length])];
NSTextCheckingResult *matchGrowler = [regExp firstMatchInString:_growler.text options:0 range:NSMakeRange(0, [_growler.text length])];

NSRegularExpression *regExp1 = [NSRegularExpression regularExpressionWithPattern:@"^(\\w+\\s?\\+ )*\\w+$" options:NSRegularExpressionCaseInsensitive error:NULL];

NSTextCheckingResult *matchDesc = [regExp1 firstMatchInString:_itemDesc.text.lowercaseString options:0 range:NSMakeRange(0, [_itemDesc.text length])];


msg = [[MessageController alloc] init];

if ([_itemCat.text isEqualToString:@""])
{
[msg displayMessage:@"Item Category: Field cannot be empty."];

}
else if([_itemName.text isEqualToString:@""]){
[msg displayMessage:@"Item Name: Field cannot be empty."];

}
else if([_itemDesc.text isEqualToString:@""]){
[msg displayMessage:@"Item Ingredients: Field cannot be empty."];

}
else if(!matchDesc){
[msg displayMessage:@"Item Ingredients: Please enter values separated by '+'. Example:'word + word'"];
}
else if([_petite.text isEqualToString:@""]){
[msg displayMessage:@"Petite Price: Field cannot be empty."];

}
else if(!matchPetite){
[msg displayMessage:@"Petite Price: Please enter only numbers.Ex. 99.99"];

}
else if([_regular.text isEqualToString:@""]){
[msg displayMessage:@"Regular Price: Field cannot be empty."];

}
else if(!matchRegular){
[msg displayMessage:@"Regular Price: Please enter only numbers.Ex. 99.99"];

}
else if([_growler.text isEqualToString:@""]){
[msg displayMessage:@"Growler Price: Field cannot be empty."];

}
else if(!matchGrowler){
[msg displayMessage:@"Growler Price: Please enter only numbers.Ex. 99.99"];
}
else{

NSString *name = _itemName.text;
NSString *cate = _itemCat.text;
NSString *desc = _itemDesc.text;
NSString *regular = _regular.text;
NSString *petite = _petite.text;
NSString *growler = _growler.text;

NSString *shFlag ,*swFlag;
NSString *locName = [self.downPickerLoc text];
    
//Change status of item location based on selected value
if([locName isEqualToString:@"Shadyside"])
{
shFlag = @"TRUE";
swFlag = @"FALSE";
}
else if([locName isEqualToString:@"Sewickley"])
{
shFlag = @"FALSE";
swFlag = @"TRUE";
}
else
{
shFlag = @"TRUE";
swFlag = @"TRUE";
}
    
NSArray *keys = [NSArray arrayWithObjects:@"item_name",@"category",@"petite",@"regular",@"growler",@"description",@"is_available_shady",@"is_available_sewickley", nil];
    
NSArray *objects = [NSArray arrayWithObjects:name,cate,petite,regular,growler,desc,shFlag,swFlag, nil];
    
GetUrl *href = [[GetUrl alloc] init];
NSString *url = [href getHref:4];

    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet."];
    }
    else
    {
RemoteLogin *remote = [[RemoteLogin alloc] init];
int res = [remote getConnection:keys forobjects:objects forurl:url];

if(res==1)
{
     if([remote.errorMsg containsString:@"not connect"])
     {
         [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
     }
     else
     {
         [msg displayMessage:[@"Error Occured: " stringByAppendingString:remote.errorMsg.description]];
     }
}
else
{
[msg displayMessage:@"Menu Created Successfully"];
[self clearButton:sender];
}
    }
}
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/

- (IBAction)newCategoryBtn:(id)sender {
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"New Category Input" message:@"Please enter new category name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create Category",nil];
    
    //set the style type of alertbox whether single or multiple inputs needed
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    //create a textfield for username
    UITextField * uname = [alertView textFieldAtIndex:0];
    uname.keyboardType = UIKeyboardTypeDefault;
    uname.placeholder = @"Category Name";
    
    //display the alertbox
    [alertView show];
    
    //Get textfield values from pop-up box
    /*if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
       
        NSString *categoryName =[alertView textFieldAtIndex:0].text;
       
        if (![categoryList containsObject:categoryName]) {
            [categoryList addObject:categoryName];
        }
    }*/
}

- (IBAction)addonBtn:(id)sender {
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"New Add-on Input" message:@"Please enter new Add-on name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create Addon",nil];
    
    //Keyboard Style
    [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    
    //set the style type of alertbox whether single or multiple inputs needed
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    //create a textfield for username
    UITextField * addonname = [alertView textFieldAtIndex:0];
    addonname.keyboardType = UIKeyboardTypeDefault;
    addonname.placeholder = @"Add-on Name";
    
    //display the alertbox
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:1];
    int urlIndx;
    NSString *key = [[NSString alloc] init];
    NSString *value = [[NSString alloc] init];
    NSString *alertMsg = [[NSString alloc] init];
    
    if ([buttonTitle isEqualToString:@"Create Addon"])
    {
        urlIndx = 8;
        key = @"addons";
        value = [alertView textFieldAtIndex:0].text;
        alertMsg = @"Add-On created successfully";
    }
    else
    {
        urlIndx = 2;
        key = @"category_name";
        value = [alertView textFieldAtIndex:0].text;
        alertMsg = @"New Category created successfully";
    }
    
        NSArray *keys = [NSArray arrayWithObjects:key, nil];
        
        NSArray *objects = [NSArray arrayWithObjects:value, nil];
        
        GetUrl *href = [[GetUrl alloc] init];
        NSString *url = [href getHref:urlIndx];
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection avialable..Please connect to the internet.."];
    }
    else
    {
        RemoteLogin *remote = [[RemoteLogin alloc] init];
        int res = [remote getConnection:keys forobjects:objects forurl:url];
        
        if(res==1)
        {
            if([remote.errorMsg containsString:@"not connect"])
            {
                [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
            }
            else
            {
                [msg displayMessage:[@"Error Occured: " stringByAppendingString:remote.errorMsg.description]];
            }
        }
        else
        {
            [msg displayMessage:alertMsg];
        }
}
}

@end
