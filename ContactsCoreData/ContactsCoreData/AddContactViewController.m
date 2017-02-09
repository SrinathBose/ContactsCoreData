//
//  ViewController.m
//  ContactsCoreData
//
//  Created by Srinath Bose on 2/6/17.
//  Copyright © 2017 Trimble. All rights reserved.
//

#import "AddContactViewController.h"
#import "coreData/CoreData.h"
#import "ViewContactsTableViewController.h"

#define ContactsTableViewControllerIdentifier "ViewContactsTableViewController"

@interface AddContactViewController ()
@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    }

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)addContactBtn:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object    
    NSManagedObject *newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts" inManagedObjectContext:context];
   
    [newContact setValue:self.nameTextFiled.text forKey:@"nameStr"];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *phoneNum = [numberFormatter numberFromString:self.phoneTextField.text];
    
    [newContact setValue:phoneNum forKey:@"phoneInt"];
    [newContact setValue:self.mailTextField.text forKey:@"mailStr"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    // Navigation
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
