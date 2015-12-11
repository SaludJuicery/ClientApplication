//
//  RewardsViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/28/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "RewardsViewController.h"
#import "SWRevealViewController.h"
#import "MessageController.h"
#import "RadioButton.h"
#import "RemoteLogin.h"
#import "GetUrl.h"
#import "GetCategories.h"
#import "GetMenuItems.h"
#import "Reachability.h"

@interface RewardsViewController ()

@end

@implementation RewardsViewController
@synthesize btnRadioPercent;
@synthesize btnRadioPrice;
@synthesize btnEndCheckbox;
@synthesize btnStartCheckbox;


- (void)viewDidLoad {
[super viewDidLoad];

    int i;
    for(i=1;i<=6;i++)
    {
        UITextField *textField=(UITextField *)[self.view viewWithTag:i];
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    
    
//Below code is for Slide Menu
_btnMenu.target=self.revealViewController;
_btnMenu.action=@selector(revealToggle:);
[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];


    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {

    GetCategories *categories = [[GetCategories alloc] init];
        NSMutableArray* menuCategories = [categories getData:3];
    self.downPickerCat = [[DownPicker alloc] initWithTextField:self.txtFldCategory withData:menuCategories];
    }
    
    [self.downPickerCat addTarget:self
                        action:@selector(getMenuItems:)
              forControlEvents:UIControlEventValueChanged];
    
// create the array of data for location and bind to location field
NSMutableArray* arrLoc = [[NSMutableArray alloc] init];
[arrLoc addObject:@"ShadySide"];
[arrLoc addObject:@"Sewickly"];
self.downPickerLoc = [[DownPicker alloc] initWithTextField:self.txtFldLocation withData:arrLoc];

//Initialize the radio button images to uncheck
[btnRadioPrice setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
[btnRadioPercent setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
[btnStartCheckbox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
[btnEndCheckbox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];

self.txtFldStartDate.delegate =self;
UIDatePicker *datePicker = [[UIDatePicker alloc]init];
datePicker.datePickerMode = UIDatePickerModeDate;
[datePicker setDate:[NSDate date]];
[datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
[self.txtFldStartDate setInputView:datePicker];

self.txtFldEndDate.delegate =self;
UIDatePicker *datePicker1 = [[UIDatePicker alloc]init];
datePicker1.datePickerMode = UIDatePickerModeDate;
[datePicker1 setDate:[NSDate date]];
[datePicker1 addTarget:self action:@selector(updateTextField1:) forControlEvents:UIControlEventValueChanged];
[self.txtFldEndDate setInputView:datePicker1];

}

//Get Menu Items from db based on category selected
-(void)getMenuItems:(id)sender {
    
    GetMenuItems *getMenuItems = [[GetMenuItems alloc] init];
    
    NSMutableArray *menuItems = [getMenuItems getMenuItems:[self.downPickerCat text]];
    
    self.downPickerItem = [[DownPicker alloc] initWithTextField:self.txtFldItem withData:menuItems];
}

//Method to set the selected start date to the date text field
-(void)updateTextField:(id)sender
{
if([_txtFldStartDate isFirstResponder]){
UIDatePicker *picker = (UIDatePicker*)_txtFldStartDate.inputView;
_txtFldStartDate.text = [self formatDate:picker.date];

//To uncheck checkbox when datepicker is shown
[btnStartCheckbox setSelected:NO];
}
}

//Method to set the selected end date to the date text field
-(void)updateTextField1:(id)sender
{
if([_txtFldEndDate isFirstResponder]){
UIDatePicker *picker = (UIDatePicker*)_txtFldEndDate.inputView;
_txtFldEndDate.text = [self formatDate:picker.date];

//To uncheck checkbox when datepicker is shown
[btnEndCheckbox setSelected:NO];
}
}


// Formats the date chosen with the date picker.
- (NSString *)formatDate:(NSDate *)date
{
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateStyle:NSDateFormatterShortStyle];
[dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
NSString *formattedDate = [dateFormatter stringFromDate:date];
return formattedDate;
}

//Method to change radio and checkbox images from check to uncheck or vice-versa
-(void)viewDidAppear:(BOOL)animated{

[btnRadioPrice setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
[btnRadioPrice setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
[btnRadioPrice addTarget:self action:@selector(onRadioBtn:) forControlEvents:UIControlEventTouchUpInside];

[btnRadioPercent setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
[btnRadioPercent setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
[btnRadioPercent addTarget:self action:@selector(onRadioBtn:) forControlEvents:UIControlEventTouchUpInside];

[btnStartCheckbox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
[btnStartCheckbox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateSelected];
[btnStartCheckbox addTarget:self action:@selector(onCheckBoxBtn:) forControlEvents:UIControlEventTouchUpInside];

[btnEndCheckbox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
[btnEndCheckbox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateSelected];
[btnEndCheckbox addTarget:self action:@selector(onCheckBoxBtn:) forControlEvents:UIControlEventTouchUpInside];


}

//Method to check the radio button status and update the image
-(IBAction)onRadioBtn:(RadioButton*)sender
{
switch ([sender tag]) {
case 1:
if([btnRadioPrice isSelected]==YES)
{
[btnRadioPrice setSelected:NO];
[btnRadioPercent setSelected:YES];
}
else{
[btnRadioPrice setSelected:YES];
[btnRadioPercent setSelected:NO];
}

break;
case 2:
if([btnRadioPercent isSelected]==YES)
{
[btnRadioPercent setSelected:NO];
[btnRadioPrice setSelected:YES];
}
else{
[btnRadioPercent setSelected:YES];
[btnRadioPrice setSelected:NO];
}

break;
default:
break;
}
}

//Method to check the checkbox status and update the image
- (IBAction)onCheckBoxBtn:(id)sender{
switch ([sender tag]) {
case 1:
if([btnStartCheckbox isSelected]==YES)
{
_txtFldStartDate.text=@"";
[btnStartCheckbox setSelected:NO];
}
else{
//If checkbox is selected set the date to the textbox
NSDate* date = [NSDate date];
NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
formatter.timeZone = destinationTimeZone;
[formatter setDateStyle:NSDateFormatterLongStyle];
[formatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
NSString* dateString = [formatter stringFromDate:date];
_txtFldStartDate.text = dateString;

[btnStartCheckbox setSelected:YES];
}
break;
case 2:
if([btnEndCheckbox isSelected]==YES)
{
_txtFldEndDate.text=@"";
[btnEndCheckbox setSelected:NO];
}
else{
//If checkbox is selected set the date to the textbox
NSDate* date = [NSDate date];
NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
formatter.timeZone = destinationTimeZone;
[formatter setDateStyle:NSDateFormatterLongStyle];
[formatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
NSString* dateString = [formatter stringFromDate:date];
_txtFldEndDate.text = dateString;

[btnEndCheckbox setSelected:YES];
}
break;
default:
break;
}

}


- (IBAction)addReward:(id)sender {

NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$" options:NSRegularExpressionCaseInsensitive error:NULL];
NSTextCheckingResult *match = [regExp firstMatchInString:_txtFldAmount.text options:0 range:NSMakeRange(0, [_txtFldAmount.text length])];

    msg = [[MessageController alloc] init];

if ([_txtFldCategory.text isEqualToString:@""])
{
[msg displayMessage:@"Category: Field cannot be empty."];

}
else if([_txtFldItem.text isEqualToString:@""]){
[msg displayMessage:@"Item Field cannot be empty."];

}
else if([_txtFldLocation.text isEqualToString:@""]){
[msg displayMessage:@"Location Field cannot be empty."];

}
else if([_txtFldAmount.text isEqualToString:@""]){
[msg displayMessage:@"Amount Field cannot be empty."];

}
else if(!match){
[msg displayMessage:@"Amount field: Please enter only numbers.Ex. 99.99, 45,etc."];
}
else if([_txtFldStartDate.text isEqualToString:@""]){
[msg displayMessage:@"Start Date Field cannot be empty."];
}
else if([_txtFldEndDate.text isEqualToString:@""]){
[msg displayMessage:@"End Date Field cannot be empty."];
}
else{

NSString *name = _txtFldItem.text;
NSString *cate = _txtFldCategory.text;
NSString *stdate = _txtFldStartDate.text;
NSString *eddate = _txtFldEndDate.text;
NSString *loc = _txtFldLocation.text;

NSString *price= [_txtFldAmount.text stringByReplacingOccurrencesOfString:@"%" withString:@""];

if([btnRadioPercent isSelected])
{
price = [NSString stringWithFormat:@"%@ %@", price,@"%"];
}
else
{
price = [NSString stringWithFormat:@"%@%@", @"$",price];
}


NSArray *keys = [NSArray arrayWithObjects:@"item_name", @"category",@"price",@"start_date",@"end_date",@"location", nil];
NSArray *objects = [NSArray arrayWithObjects:name,cate,price,stdate,eddate,loc, nil];

GetUrl *href = [[GetUrl alloc] init];
NSString *url = [href getHref:9];

RemoteLogin *remote = [[RemoteLogin alloc] init];
    
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {
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
[msg displayMessage:@"Offer Created Successfully"];
[self clearFields:sender];
}
    }
}
}

- (IBAction)clearFields:(id)sender {

int i;

for(i=1;i<=6;i++)
{
UITextField *textField=(UITextField *)[self.view viewWithTag:i];
[textField setText:@""];
}
[btnRadioPercent setSelected:NO];
[btnRadioPrice setSelected:NO];
[btnStartCheckbox setSelected:NO];
[btnEndCheckbox setSelected:NO];
}

- (void)didReceiveMemoryWarning {
[super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}

- (void)applicationFinishedRestoringState
{
/* SWRevealViewController *revealViewController = self.revealViewController;
if ( revealViewController )
{
_rewardsButton.target=self.revealViewController;
_rewardsButton.action=@selector(revealToggle:);
[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}*/
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/
@end
