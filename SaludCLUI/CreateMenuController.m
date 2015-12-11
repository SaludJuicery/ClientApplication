//
//  CreateMenuController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/13/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "CreateMenuController.h"
#import "RemoteLogin.h"
#import "RemoteGetData.h"
#import "MessageController.h"
#import "DownPicker.h"
#import "GetUrl.h"
#import "GetCategories.h"
#import "Reachability.h"
#import "AppDelegate.h"

@interface CreateMenuController ()
{
    AppDelegate *appDelegate;
    NSString *openTime;
    NSString *closeTime;
    NSString *currentTime;
    int createFlag;
}
@end

@implementation CreateMenuController
@synthesize categoryList;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Get Time
    [self getTime];
    
    //Compare Time
    [self compareTime];
    
    msg = [[MessageController alloc] init];
    
    for(int i=1;i<=7;i++)
    {
        UITextField *textField=(UITextField *)[self.view viewWithTag:i];
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    
    self.txtViewDesc.layer.cornerRadius = 5;
    self.txtViewDesc.layer.borderWidth = 0.5f;
    self.txtViewDesc.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
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
        categoryList = [getCategory getData:3];
        self.downPickerCat = [[DownPicker alloc] initWithTextField:_txtFldCat withData:categoryList];
    }
    
NSMutableArray* arrLoc = [[NSMutableArray alloc] init];
[arrLoc addObject:@"ShadySide"];
[arrLoc addObject:@"Sewickley"];
[arrLoc addObject:@"Both"];
self.downPickerLoc = [[DownPicker alloc] initWithTextField:self.txtFldLocation withData:arrLoc];
}

-(void)getTime
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 
    int res1;
    
    NSString *locName = appDelegate.location;
    GetUrl *href = [[GetUrl alloc] init];
    NSString *url = [href getHref:12];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dayName = [dateFormatter stringFromDate:[NSDate date]];

    if([locName containsString:@"shady"])
    {
        locName = @"Shadyside";
    }
    else
    {
        locName = @"Sewickley";
    }
    
    NSArray *keys = [NSArray arrayWithObjects:@"location",@"day", nil];
    NSArray *objects = [NSArray arrayWithObjects:locName,dayName, nil];
    
    RemoteGetData *remote = [[RemoteGetData alloc] init];
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
        if (networkStatus == NotReachable) {
            [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
        }
        else
        {
            res1 = [remote getJsonData:keys forobjects:objects forurl:url];
            
            if(res1 == 1)
            {
                if([remote.errorMsg containsString:@"not connect"])
                {
                    [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
                }
                else
                {
                    [msg displayMessage:[@"Error Occured: " stringByAppendingString:@"Some Error occured with the application. Please try again..."]];
                }
            }
            else if(res1 == 2)
            {
                //Receive the timings as dict and store in array
                NSMutableArray *hoursArray = remote.jsonData;

                NSDictionary *itemDict = [hoursArray objectAtIndex:0];
                
                openTime = [itemDict objectForKey:@"open_time"];
                closeTime = [itemDict objectForKey:@"close_time"];
            }
        }
}


-(void)compareTime
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    currentTime = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *cTime1= [dateFormatter dateFromString:openTime];
    NSDate *cTime2 = [dateFormatter dateFromString:closeTime];
    NSDate *systemTime = [dateFormatter dateFromString:currentTime];
    
   // NSLog(@"Open:%@",[dateFormatter stringFromDate:cTime1]);
   // NSLog(@"Close:%@",[dateFormatter stringFromDate:cTime2]);
   // NSLog(@"System:%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    NSComparisonResult openTimeResult = [[dateFormatter stringFromDate:systemTime] compare:[dateFormatter stringFromDate:cTime1]];
    NSComparisonResult closeTimeResult = [[dateFormatter stringFromDate:systemTime] compare:[dateFormatter stringFromDate:cTime2]];
    
    if(openTimeResult == NSOrderedDescending && closeTimeResult == NSOrderedAscending)
    {
        createFlag = 0;
    }
    else
    {
        createFlag = 1;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
        if([text isEqualToString:@"\n"])
        {
                [textView resignFirstResponder];
        }
    return TRUE;
    
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
_txtViewDesc.text = @"";
_txtFldLocation.text=@"";
}

-(void)submitButton:(id)sender {

NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$" options:NSRegularExpressionCaseInsensitive error:NULL];

NSTextCheckingResult *matchPetite = [regExp firstMatchInString:_txtFldPetite.text options:0 range:NSMakeRange(0, [_txtFldPetite.text length])];
NSTextCheckingResult *matchRegular = [regExp firstMatchInString:_txtFldRegular.text options:0 range:NSMakeRange(0, [_txtFldRegular.text length])];
NSTextCheckingResult *matchGrowler = [regExp firstMatchInString:_txtFldGrowler.text options:0 range:NSMakeRange(0, [_txtFldGrowler.text length])];

NSRegularExpression *regExp1 = [NSRegularExpression regularExpressionWithPattern:@"^(\\w+\\s?\\+ )*\\w+$" options:NSRegularExpressionCaseInsensitive error:NULL];

NSTextCheckingResult *matchDesc = [regExp1 firstMatchInString:_txtViewDesc.text.lowercaseString options:0 range:NSMakeRange(0, [_txtViewDesc.text length])];

if ([_txtFldCat.text isEqualToString:@""])
{
[msg displayMessage:@"Item Category: Field cannot be empty."];

}
else if([_txtFldName.text isEqualToString:@""]){
[msg displayMessage:@"Item Name: Field cannot be empty."];

}
else if([_txtViewDesc.text isEqualToString:@""]){
[msg displayMessage:@"Item Ingredients: Field cannot be empty."];

}
else if(!matchDesc){
[msg displayMessage:@"Item Ingredients: Please enter values separated by '+'. Example:'word + word'"];
}
else if([_txtFldPetite.text isEqualToString:@""]){
[msg displayMessage:@"Petite Price: Field cannot be empty."];

}
else if(!matchPetite){
[msg displayMessage:@"Petite Price: Please enter only numbers.Ex. 99.99"];

}
else if([_txtFldRegular.text isEqualToString:@""]){
[msg displayMessage:@"Regular Price: Field cannot be empty."];

}
else if(!matchRegular){
[msg displayMessage:@"Regular Price: Please enter only numbers.Ex. 99.99"];

}
else if([_txtFldGrowler.text isEqualToString:@""]){
[msg displayMessage:@"Growler Price: Field cannot be empty."];

}
else if(!matchGrowler){
[msg displayMessage:@"Growler Price: Please enter only numbers.Ex. 99.99"];
}
else if(createFlag == 0)
{
[msg displayMessage:@"Cannot create an item. Shop is not closed yet."];
}
else{

NSString *name = _txtFldName.text;
NSString *cate = _txtFldCat.text;
NSString *desc = _txtViewDesc.text;
NSString *regular = _txtFldRegular.text;
NSString *petite = _txtFldPetite.text;
NSString *growler = _txtFldGrowler.text;

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
         [msg displayMessage:[@"Error Occured: " stringByAppendingString:@"Some Error occured with the application. Please try again..."]];
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
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"New Category Input" message:@"Please enter new category name:" delegate:self cancelButtonTitle:@"Create Category" otherButtonTitles:@"Cancel",nil];
    
    //set the style type of alertbox whether single or multiple inputs needed
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    //create a textfield for username
    UITextField * categoryName = [alertView textFieldAtIndex:0];
    categoryName.keyboardType = UIKeyboardTypeDefault;
    categoryName.placeholder = @"Category Name";
    
    //display the alertbox
    [alertView show];
    
}

- (IBAction)addonBtn:(id)sender {
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"New Add-on Input" message:@"Please enter new Add-on name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create Addon",nil];
    
    //Keyboard Style
    [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    
    //set the style type of alertbox whether single or multiple inputs needed
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    //create a textfield for username
    UITextField * addonName = [alertView textFieldAtIndex:0];
    addonName.keyboardType = UIKeyboardTypeDefault;
    addonName.placeholder = @"Add-on Name";
    
    //display the alertbox
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  
    NSString *buttonTitle = [alertView buttonTitleAtIndex:1];
    NSArray *params;
    
    if ([buttonTitle isEqualToString:@"Create Addon"])
    {
        params =  [[NSArray alloc] initWithObjects:@"addons",[alertView textFieldAtIndex:0].text,@"8",@"Add-On created successfully", nil];
    }
    else
    {
        params =  [[NSArray alloc] initWithObjects:@"category_name",[alertView textFieldAtIndex:0].text,@"2",@"New Category created successfully", nil];
    }
    
    [self createMenuItem:params];
}

-(void)createMenuItem:(NSArray *)paramArray
{

    NSArray *keys = [NSArray arrayWithObjects:paramArray[0], nil];
    
    NSArray *objects = [NSArray arrayWithObjects:paramArray[1], nil];
    
    GetUrl *href = [[GetUrl alloc] init];
    NSString *url = [href getHref:(int) paramArray[2]];
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
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
                [msg displayMessage:[@"Error Occured: " stringByAppendingString:@"Some Error occured with the application. Please try again..."]];
            }
        }
        else
        {
            [msg displayMessage:paramArray[3]];
        }
    }

}

@end
