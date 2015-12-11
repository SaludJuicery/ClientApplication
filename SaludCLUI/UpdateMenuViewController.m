//
//  UpdateMenuViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/11/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "UpdateMenuViewController.h"
#import "BorderglobalStyle.h"
#import "MessageController.h"
#import "RemoteLogin.h"
#import "GetUrl.h"
#import "DownPicker.h"
#import "GetMenuItems.h"
#import "Reachability.h"

@interface UpdateMenuViewController ()

@end

@implementation UpdateMenuViewController

- (void)viewDidLoad {
[super viewDidLoad];
    
//Get the category name
_txtFldCategory1.text = _tempCategory;

//Get the item name
_txtFldItem.text = _tempName;
    


    int i;
    
    for(i=1;i<=6;i++)
    {
        UITextField *textField=(UITextField *)[self.view viewWithTag:i];
       textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    
    //Call the function getItem to assign item details to textfields
    [self getItem:_tempName forCategory:_tempCategory];
    
// create the array of data for location and bind to location field
NSMutableArray* arrLoc = [[NSMutableArray alloc] init];
[arrLoc addObject:@"ShadySide"];
[arrLoc addObject:@"Sewickley"];
[arrLoc addObject:@"Both"];
self.downPickerLoc = [[DownPicker alloc] initWithTextField:self.txtFldLoc withData:arrLoc];

//Below border style for item ingredients
_txtViewIngre.layer.cornerRadius=5.0f;
//_itemIngre.layer.masksToBounds=YES;
_txtViewIngre.layer.borderColor=[[UIColor lightGrayColor]CGColor];
_txtViewIngre.layer.borderWidth= 1.0f;

}

-(void)getItem:(NSString *)itemName forCategory:(NSString *) catName
{

    GetMenuItems *getItems = [[GetMenuItems alloc]init];
    
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {

    NSMutableArray *menuItems = [getItems getItemDetails:catName forItemName:itemName];
    
        NSDictionary *itemDict = [menuItems objectAtIndex:0];

    
    _txtFldPetite.text = [[itemDict objectForKey:@"petite"] stringValue];
    _txtFldRegular.text = [[itemDict objectForKey:@"regular"] stringValue];
        _txtFldGrowler.text = [[itemDict objectForKey:@"growler"] stringValue];
    

    _txtViewIngre.text = [itemDict objectForKey:@"description"];
    
        NSString *shLoc = [itemDict objectForKey:@"is_available_shady"];
        NSString *swLoc = [itemDict objectForKey:@"is_available_sewickley"];

        if([shLoc isEqualToString:@"true"] && [swLoc isEqualToString:@"true"])
           {
               _txtFldLoc.text = @"Both";
           }
        else if([shLoc isEqualToString:@"true"] && [swLoc isEqualToString:@"false"])
        {
            _txtFldLoc.text = @"ShadySide";
        }
        else 
        {
            _txtFldLoc.text = @"Sewickley";
        }
    }
}


- (IBAction)UpdateMenu:(id)sender {

msg = [[MessageController alloc] init];

NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$" options:NSRegularExpressionCaseInsensitive error:NULL];

    NSTextCheckingResult *matchPetite = [regExp firstMatchInString:_txtFldPetite.text options:0 range:NSMakeRange(0, [_txtFldPetite.text length])];
    NSTextCheckingResult *matchRegular = [regExp firstMatchInString:_txtFldRegular.text options:0 range:NSMakeRange(0, [_txtFldRegular.text length])];
    NSTextCheckingResult *matchGrowler = [regExp firstMatchInString:_txtFldGrowler.text options:0 range:NSMakeRange(0, [_txtFldGrowler.text length])];

    NSRegularExpression *regExp1 = [NSRegularExpression regularExpressionWithPattern:@"^(\\w+\\s?\\+ )*\\w+$" options:NSRegularExpressionCaseInsensitive error:NULL];
    
    NSTextCheckingResult *matchIngre = [regExp1 firstMatchInString:_txtViewIngre.text.lowercaseString options:0 range:NSMakeRange(0, [_txtViewIngre.text length])];
    
    if ([_txtFldCategory1.text isEqualToString:@""])
    {
        [msg displayMessage:@"Item Category: Field cannot be empty."];
        
    }
    else if([_txtFldItem.text isEqualToString:@""]){
        [msg displayMessage:@"Item Name: Field cannot be empty."];
        
    }
    else if([_txtViewIngre.text isEqualToString:@""]){
        [msg displayMessage:@"Item Description: Field cannot be empty."];
        
    }
    else if(!matchIngre){
        [msg displayMessage:@"Item Description: Please enter values separated by '+'. Example:'word + word'"];
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
    else{

        NSString *name = _txtFldItem.text;
        NSString *cate = _txtFldCategory1.text;
        NSString *ingre = _txtViewIngre.text;
        NSString *regular = _txtFldRegular.text;
        NSString *petite = _txtFldPetite.text;
        NSString *growler = _txtFldGrowler.text;
        
        BOOL shFlag ,swFlag;
        
        if([_txtFldLoc.text isEqualToString:@"Shadyside"])
        {
            shFlag = TRUE;
            swFlag = FALSE;
        }
        else if([_txtFldLoc.text isEqualToString:@"Sewickley"])
        {
            shFlag = FALSE;
            swFlag = TRUE;
        }
        else
        {
            shFlag = TRUE;
            swFlag = TRUE;
        }


NSArray *keys = [NSArray arrayWithObjects:@"item_name", @"category",@"petite",@"regular",@"growler",@"description",@"is_available_shady",@"is_available_sewickley", nil];
NSArray *objects = [NSArray arrayWithObjects:name,cate,petite,regular,growler,ingre,shFlag,swFlag, nil];


//Below URL needs to be updated in backend for update
    
GetUrl *href = [[GetUrl alloc] init];
NSString *url = [href getHref:6];
    
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
[msg displayMessage:@"Menu Updated Successfully"];
}
        }
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/

@end
