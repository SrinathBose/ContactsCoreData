//
//  ContactsTableViewModel.m
//  ContactsCoreData
//
//  Created by Srinath Bose on 2/7/17.
//  Copyright © 2017 Trimble. All rights reserved.
//

#import "ViewContactsTableViewModel.h"
#import "CoreData/CoreData.h"

#define CellIdentifier "CellIdentifier"

@interface ViewContactsTableViewModel (){
    NSManagedObject *contactsManagedObjects;
}
@end

@implementation ViewContactsTableViewModel
- (id)init
{
    if(self = [super init])
    {
        [self getData];
    }
    return self;
}

-(void) getData{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Contacts"];
    self.contactsArr = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"Contacts Size Is %ld", [_contactsArr count]);
}

-(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_contactsArr count];
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    contactsManagedObjects = [self.contactsArr objectAtIndex:indexPath.row];
    _keyPhoneInt = [contactsManagedObjects valueForKey:@"phoneInt"];
    NSLog(@"Phone Number %@",_keyPhoneInt);
    
    [self.keyDelegate getKey:self didSelectContact:_keyPhoneInt];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.contactsArr objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [self.contactsArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    NSManagedObject *contact = [self.contactsArr objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [contact valueForKey:@"nameStr"], [contact valueForKey:@"phoneInt"]]];
    [cell.detailTextLabel setText:[contact valueForKey:@"mailStr"]];

    return cell;
}
@end
