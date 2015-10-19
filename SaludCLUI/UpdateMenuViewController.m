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

@interface UpdateMenuViewController ()

@end

@implementation UpdateMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _itemName.text = _tempName;
    
    //Below style is for Item Description

    //BorderGlobalStyle *style = [[BorderGlobalStyle alloc] init];
    
    //[style setBorderForColor:[UIColor redColor] width:1.0f radius:8.0f ];
    
    _itemDesc.layer.cornerRadius=5.0f;
    //_itemDesc.layer.masksToBounds=YES;
    _itemDesc.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _itemDesc.layer.borderWidth= 1.0f;
    
    //Below border style for item ingredients
    _itemIngre.layer.cornerRadius=5.0f;
    //_itemIngre.layer.masksToBounds=YES;
    _itemIngre.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _itemIngre.layer.borderWidth= 1.0f;
    
}

- (IBAction)UpdateMenu:(id)sender {
    
    MessageController *msg = [[MessageController alloc] init];
    
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"\\d{1,2}(\\.\\d{1,2})?" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSTextCheckingResult *match = [regExp firstMatchInString:_itemPrice.text options:0 range:NSMakeRange(0, [_itemPrice.text length])];
   
    
    if ([_itemCat.text isEqualToString:@""])
    {
        [msg displayMessage:@"Item Category: Field cannot be empty."];
        [_itemCat becomeFirstResponder];
    }
    else if([_itemName.text isEqualToString:@""]){
        [msg displayMessage:@"Item Name: Field cannot be empty."];
        [_itemName becomeFirstResponder];
    }
    else if([_itemDesc.text isEqualToString:@""]){
        [msg displayMessage:@"Item Description: Field cannot be empty."];
        [_itemDesc becomeFirstResponder];
    }
    else if([_itemIngre.text isEqualToString:@""]){
        [msg displayMessage:@"Item Ingredients: Field cannot be empty."];
        [_itemIngre becomeFirstResponder];
    }
    else if(!match){
        [msg displayMessage:@"Item Price: Please enter only numbers.Ex. 99.99"];
        [_itemPrice becomeFirstResponder];
    }
    else{
        
        NSString *name = _itemName.text;
        NSString *cate = _itemCat.text;
        NSString *desc = _itemDesc.text;
        NSString *ingre = _itemIngre.text;
        NSString *price = _itemPrice.text;
        
        NSArray *keys = [NSArray arrayWithObjects:@"item_name", @"category",@"price",@"description",@"ingredients", nil];
        NSArray *objects = [NSArray arrayWithObjects:name,cate,price,desc,ingre, nil];
        
        //Below URL needs to be updated in backend for update
        NSString *url = @"http://ec2-52-88-11-130.us-west-2.compute.amazonaws.com:3000/menu/menuItem/update";
        
        RemoteLogin *remote = [[RemoteLogin alloc] init];
        int res = [remote getConnection:keys forobjects:objects forurl:url];
        
        if(res==1)
        {
            [msg displayMessage:@"Connection Error: Please try again..."];
        }
        else
        {
            [msg displayMessage:@"Menu Updated Successfully"];
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
