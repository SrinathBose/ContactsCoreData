//
//  EditContactViewController.h
//  ContactsCoreData
//
//  Created by Srinath Bose on 2/7/17.
//  Copyright © 2017 Trimble. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditContactViewController : UIViewController

- (IBAction)updateContactBtn:(id)sender;
-(void)getDataFromDB;

@property(strong,nonatomic)NSNumber *keyPhoneInt;

@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;

@end
