//
//  ViewController.h
//  ContactsCoreData
//
//  Created by Srinath Bose on 2/6/17.
//  Copyright © 2017 Trimble. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewContactsTableViewController.h"

@interface AddContactViewController : UIViewController
- (IBAction)addContactBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;


@end

