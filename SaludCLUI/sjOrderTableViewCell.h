//
//  sjOrderTableViewCell.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 12/4/15.
//  Copyright © 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageController.h"

@interface sjOrderTableViewCell : UITableViewCell
{

}
@property (weak, nonatomic) IBOutlet UIButton *btnComplete;
@property (weak, nonatomic) IBOutlet UIButton *btnFailue;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblAddOn;
@property (weak, nonatomic) IBOutlet UILabel *lblNotes;

@property (weak, nonatomic) IBOutlet UILabel *lblOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblQty;
@property (weak, nonatomic) IBOutlet UILabel *lblSize;



@end
