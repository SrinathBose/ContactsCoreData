t//
//  EditContactViewController.m
//  ContactsCoreData
//
//  Created by Srinath Bose on 2/7/17.
//  Copyright © 2017 Trimble. All rights reserved.
//

#import "EditContactViewController.h"
#import "CoreData/CoreData.h"

@interface EditContactViewController ()
    @property (strong,nonatomic) NSManagedObjectContext *contactContext;
    @property (strong,nonatomic) NSManagedObject *contactObj;
@end

@implementation EditContactViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _contactContext = [self managedObjectContext];
    NSLog(@"Received Data %@",_keyPhoneInt);
    [self getDataFromDB];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (NSManagedObject*)getContactWithPhoneNumber:(NSNumber*)phNumber
{
    NSEntityDescription *updatedContact=[NSEntityDescription entityForName:@"Contacts" inManagedObjectContext:_contactContext];
    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
    
    NSPredicate *query=[NSPredicate predicateWithFormat:@"phoneInt == %@", phNumber];
    [fetch setEntity:updatedContact];
    [fetch setPredicate:query];
    [fetch setResultType:NSDictionaryResultType];
    
    NSError *fetchError;
    
    NSArray* fetchedData = [_contactContext executeFetchRequest:fetch error:&fetchError];
    NSManagedObject* contactObj = [fetchedData objectAtIndex:0];
   
    NSLog(@"Current contact obj name : %@", [contactObj valueForKey:@"nameStr"]);
    NSLog(@"Current contact obj ph number : %@", [contactObj valueForKey:@"phoneInt"]);
   
    return contactObj;
}

-(void)getDataFromDB{
    _contactObj = [self getContactWithPhoneNumber:_keyPhoneInt];
    _nameTextFiled.text =[_contactObj valueForKey:@"nameStr"];
    _phoneTextField.text = [[_contactObj valueForKey:@"phoneInt"] stringValue];
    _mailTextField.text = [_contactObj valueForKey:@"mailStr"];
}

- (IBAction)updateContactBtn:(id)sender {
   
    _contactObj = [self getContactWithPhoneNumber:_keyPhoneInt];

    [_contactObj setValue:_nameTextFiled.text forKey:@"nameStr"];
    [_contactObj setValue:_mailTextField.text forKey:@"mailStr"];
    
    NSLog(@"Current edited contact obj name : %@", [_contactObj valueForKey:@"nameStr"]);
    NSLog(@"Current edited contact obj ph number : %@", [_contactObj valueForKey:@"phoneInt"]);
    
    NSError* saveError;
    if(![_contactContext save:&saveError]){
        NSLog(@"Error While Store...");
    }
    
    [self getDataFromDB];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
