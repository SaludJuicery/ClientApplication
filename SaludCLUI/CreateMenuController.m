//
//  CreateMenuController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/13/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "CreateMenuController.h"

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
    
    if ([_itemCat.text isEqualToString:@""])
    {
        [self displayMessage:@"Item Category: Field cannot be empty."];
        [_itemCat becomeFirstResponder];
    }
    else if([_itemName.text isEqualToString:@""]){
        [self displayMessage:@"Item Name: Field cannot be empty."];
        [_itemName becomeFirstResponder];
    }
    else if([_itemDesc.text isEqualToString:@""]){
        [self displayMessage:@"Item Description: Field cannot be empty."];
        [_itemDesc becomeFirstResponder];
    }
    else if([_itemIngre.text isEqualToString:@""]){
        [self displayMessage:@"Item Ingredients: Field cannot be empty."];
        [_itemIngre becomeFirstResponder];
    }
    else if(!match){
        [self displayMessage:@"Item Price: Please enter only numbers.Ex. 99.99"];
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
        NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];//This var holds the json object
        [self displayMessage:@"Menu Created Successfully"];
        NSLog(@"menu:%@", result);

    }
}

-(void)displayMessage:(NSString *)msg {

    UIAlertView *alert = [[UIAlertView alloc]
                      initWithTitle:@"Error Message"
                      message:[NSString stringWithFormat:@"%@",msg]
                      delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil];

[alert show];
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
