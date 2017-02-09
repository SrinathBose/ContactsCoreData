//
//  ContactsTableViewController.h
//  ContactsCoreData
//
//  Created by Srinath Bose on 2/7/17.
//  Copyright © 2017 Trimble. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewContactsTableViewModel.h"

@interface ViewContactsTableViewController : UITableViewController <ViewContactsDelegate>

@property (strong) NSMutableArray *contactsArr;
@property (strong) NSNumber *keyPhoneInt;

@end
