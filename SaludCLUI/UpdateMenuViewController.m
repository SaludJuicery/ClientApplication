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
    //NSString *menuData;
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
