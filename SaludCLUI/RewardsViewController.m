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

@interface RewardsViewController ()

@end

@implementation RewardsViewController
@synthesize radioPercent;
@synthesize radioPrice;
@synthesize endcheckbox;
@synthesize startcheckbox;


- (void)viewDidLoad {
    [super viewDidLoad];
    
        //Below code is for Slide Menu
        _rewardsButton.target=self.revealViewController;
        _rewardsButton.action=@selector(revealToggle:);
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // create the array of data for menu categories and bind to category field and downpicker
    NSMutableArray* menuCategories = [[NSMutableArray alloc] init];
    [menuCategories addObject:@"Smoothies"];
    [menuCategories addObject:@"Juices & Refereshers"];
    [menuCategories addObject:@"Hot Shots"];
    [menuCategories addObject:@"Hot Drinks"];
    [menuCategories addObject:@"Cleanses"];
    [menuCategories addObject:@"Medicinal"];
    self.downPickerCat = [[DownPicker alloc] initWithTextField:self.textCategory withData:menuCategories];
    
    // create the array of data for menu items based upon category selected and bind to item field and downpicker
    NSMutableArray* menuItems = [[NSMutableArray alloc] init];
    [menuItems addObject:@"Red Headed Irish"];
    [menuItems addObject:@"Pom-Cha-Cha"];
    [menuItems addObject:@"Jane Good’All"];
    [menuItems addObject:@"Jungle VIP"];
    [menuItems addObject:@"Racers Edge"];
    [menuItems addObject:@"Brain On"];
    self.downPickerItem = [[DownPicker alloc] initWithTextField:self.textItem withData:menuItems];
    
    
    // create the array of data for location and bind to location field
    NSMutableArray* arrLoc = [[NSMutableArray alloc] init];
    [arrLoc addObject:@"ShadySide"];
    [arrLoc addObject:@"Sewickly"];
    self.downPickerLoc = [[DownPicker alloc] initWithTextField:self.textLocation withData:arrLoc];
    
   //Initialize the radio button images to uncheck
    [radioPrice setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [radioPercent setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [startcheckbox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [endcheckbox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    
    self.startDate.delegate =self;
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.startDate setInputView:datePicker];
    
    self.endDate.delegate =self;
    UIDatePicker *datePicker1 = [[UIDatePicker alloc]init];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    [datePicker1 setDate:[NSDate date]];
    [datePicker1 addTarget:self action:@selector(updateTextField1:) forControlEvents:UIControlEventValueChanged];
    [self.endDate setInputView:datePicker1];

}

//Method to set the selected start date to the date text field
-(void)updateTextField:(id)sender
{
    if([_startDate isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)_startDate.inputView;
        _startDate.text = [self formatDate:picker.date];
        
        //To uncheck checkbox when datepicker is shown
        [startcheckbox setSelected:NO];
    }
}

//Method to set the selected end date to the date text field
-(void)updateTextField1:(id)sender
{
    if([_endDate isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)_endDate.inputView;
        _endDate.text = [self formatDate:picker.date];
        
        //To uncheck checkbox when datepicker is shown
        [endcheckbox setSelected:NO];
    }
}


// Formats the date chosen with the date picker.
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

//Method to change radio and checkbox images from check to uncheck or vice-versa
-(void)viewDidAppear:(BOOL)animated{

    [radioPrice setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [radioPrice setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [radioPrice addTarget:self action:@selector(onRadioBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [radioPercent setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [radioPercent setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [radioPercent addTarget:self action:@selector(onRadioBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [startcheckbox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [startcheckbox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateSelected];
    [startcheckbox addTarget:self action:@selector(onCheckBoxBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [endcheckbox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [endcheckbox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateSelected];
    [endcheckbox addTarget:self action:@selector(onCheckBoxBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

//Method to check the radio button status and update the image
-(IBAction)onRadioBtn:(RadioButton*)sender
{
    switch ([sender tag]) {
        case 1:
            if([radioPrice isSelected]==YES)
            {
                [radioPrice setSelected:NO];
                [radioPercent setSelected:YES];
            }
            else{
                [radioPrice setSelected:YES];
                [radioPercent setSelected:NO];
            }
            
            break;
        case 2:
            if([radioPercent isSelected]==YES)
            {
                [radioPercent setSelected:NO];
                [radioPrice setSelected:YES];
            }
            else{
                [radioPercent setSelected:YES];
                [radioPrice setSelected:NO];
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
            if([startcheckbox isSelected]==YES)
            {
               _startDate.text=@"";
                [startcheckbox setSelected:NO];
            }
            else{
                //If checkbox is selected set the date to the textbox
                NSDate* date = [NSDate date];
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
                formatter.timeZone = destinationTimeZone;
                [formatter setDateStyle:NSDateFormatterLongStyle];
                [formatter setDateFormat:@"MM/dd/yyyy"];
                NSString* dateString = [formatter stringFromDate:date];
                _startDate.text = dateString;
                
                [startcheckbox setSelected:YES];
            }
            break;
        case 2:
            if([endcheckbox isSelected]==YES)
            {
                 _endDate.text=@"";
                [endcheckbox setSelected:NO];
            }
            else{
                //If checkbox is selected set the date to the textbox
                NSDate* date = [NSDate date];
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
                formatter.timeZone = destinationTimeZone;
                [formatter setDateStyle:NSDateFormatterLongStyle];
                [formatter setDateFormat:@"MM/dd/yyyy"];
                NSString* dateString = [formatter stringFromDate:date];
                _endDate.text = dateString;

                [endcheckbox setSelected:YES];
            }
            break;
        default:
            break;
    }

}


- (IBAction)addReward:(id)sender {

    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSTextCheckingResult *match = [regExp firstMatchInString:_textAmount.text options:0 range:NSMakeRange(0, [_textAmount.text length])];
    
    MessageController *msg = [[MessageController alloc] init];
    
    if ([_textCategory.text isEqualToString:@""])
    {
        [msg displayMessage:@"Category: Field cannot be empty."];
        
    }
    else if([_textItem.text isEqualToString:@""]){
        [msg displayMessage:@"Item Field cannot be empty."];
        
    }
    else if([_textLocation.text isEqualToString:@""]){
        [msg displayMessage:@"Location Field cannot be empty."];
        
    }
    else if([_textAmount.text isEqualToString:@""]){
        [msg displayMessage:@"Amount Field cannot be empty."];
        
    }
    else if(!match){
        [msg displayMessage:@"Amount field: Please enter only numbers.Ex. 99.99, 45,etc."];
    }
    else if([_startDate.text isEqualToString:@""]){
        [msg displayMessage:@"Start Date Field cannot be empty."];
    }
    else if([_endDate.text isEqualToString:@""]){
        [msg displayMessage:@"End Date Field cannot be empty."];
    }
    else{
        
        NSString *name = _textItem.text;
        NSString *cate = _textCategory.text;
        NSString *stdate = _startDate.text;
         NSString *eddate = _endDate.text;
        NSString *loc = _textLocation.text;
       
        NSString *price= [_textAmount.text stringByReplacingOccurrencesOfString:@"%" withString:@""];
        
        if([radioPercent isSelected])
        {
         price = [NSString stringWithFormat:@"%@ %@", price,@"%"];
        }
        else
        {
         price = [NSString stringWithFormat:@"%@%@", @"$",price];
        }
       
    
        NSArray *keys = [NSArray arrayWithObjects:@"item_name", @"category",@"price",@"start_date",@"end_date",@"location", nil];
        NSArray *objects = [NSArray arrayWithObjects:name,cate,price,stdate,eddate,loc, nil];
        
        NSString *url = @"http://ec2-52-88-11-130.us-west-2.compute.amazonaws.com:3000/menu/reward/insert";
        
        RemoteLogin *remote = [[RemoteLogin alloc] init];
        int res = [remote getConnection:keys forobjects:objects forurl:url];
        
        if(res==1)
        {
            [msg displayMessage:@"Connection Error: Please try again..."];
        }
        else
        {
            [msg displayMessage:@"Offer Created Successfully"];
            [self clearFields:sender];
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
    [radioPercent setSelected:NO];
    [radioPrice setSelected:NO];
    [startcheckbox setSelected:NO];
    [endcheckbox setSelected:NO];
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
