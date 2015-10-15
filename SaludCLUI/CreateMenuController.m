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

@interface CreateMenuController ()

@end

@implementation CreateMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    //Below code loads the category value from menucontroller
    self.itemCat.text = _tempCat;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*BElow FUnction is used to clear all the fields in the screen*/
-(void)clearButton:(id)sender
{
    int i;
    
    for(i=1;i<=5;i++)
    {
        UITextField *textField=(UITextField *)[self.view viewWithTag:i];
        [textField setText:@""];
    }

}

/*Below function is used to submit the data as entered by the user*/
-(void)submitButton:(id)sender {

    //\d{1,2}(\.\d{1,2})?
    //[0-9]?[0-9]?(\.[0-9][0-9]?)?
    //(\\d)?\\d?.\\d(\\d)?
    
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"\\d{1,2}(\\.\\d{1,2})?" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSTextCheckingResult *match = [regExp firstMatchInString:_itemPrice.text options:0 range:NSMakeRange(0, [_itemPrice.text length])];
    //NSString *menuData;
    
    MessageController *msg = [[MessageController alloc] init];
    
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
        
        NSString *url = @"http://ec2-52-88-11-130.us-west-2.compute.amazonaws.com:3000/menu/category/insert";
        
        RemoteLogin *remote = [[RemoteLogin alloc] init];
        int res = [remote getConnection:keys forobjects:objects forurl:url];

        if(res==1)
        {
            [msg displayMessage:@"Menu Created Successfully"];
        }
        else
        {
            [msg displayMessage:@"Login Error: Invalid Credentials"];
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

@end
