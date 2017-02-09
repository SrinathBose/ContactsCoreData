//
//  ContactsTableViewModel.h
//  ContactsCoreData
//
//  Created by Srinath Bose on 2/7/17.
//  Copyright © 2017 Trimble. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData/CoreData.h"

@class ViewContactsTableViewModel;

@protocol ViewContactsDelegate <NSObject>
-(void)getKey:(ViewContactsTableViewModel *)controller didSelectContact:(NSNumber *) keyPhoneInt;
@end

@interface ViewContactsTableViewModel : NSObject<UITableViewDataSource, UITableViewDelegate>
    @property (strong) NSMutableArray *contactsArr;
    @property (strong) NSNumber *keyPhoneInt;

    @property (atomic,strong) id<ViewContactsDelegate> keyDelegate;

@end
