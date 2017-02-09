    //
//  ContactsTableViewController.m
//  ContactsCoreData
//
//  Created by Srinath Bose on 2/7/17.
//  Copyright © 2017 Trimble. All rights reserved.
//

#import "ViewContactsTableViewController.h"
#import "ViewContactsTableViewModel.h"
#import "CoreData/CoreData.h"
#import "EditContactViewController.h"

#define editContactViewControllerIdentifier "EditContactViewController"

@interface ViewContactsTableViewController ()
@property (nonatomic,strong) ViewContactsTableViewModel *contactsViewModel;
@end

@implementation ViewContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contactsViewModel = [[ViewContactsTableViewModel alloc]init];
    self.tableView.delegate = self.contactsViewModel;
    self.tableView.dataSource = self.contactsViewModel;
    
    self.contactsViewModel.keyDelegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

-(void)getKey:(ViewContactsTableViewModel *)controller didSelectContact:(NSNumber *)keyPhoneInt{
    NSLog(@"New Received Data Is %@",keyPhoneInt);
    
    EditContactViewController *editContact = (EditContactViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@editContactViewControllerIdentifier];
    editContact.keyPhoneInt = keyPhoneInt;
    [self.navigationController pushViewController:editContact animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
