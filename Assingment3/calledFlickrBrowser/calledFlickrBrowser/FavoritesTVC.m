//
//  FavoritesTVC.m
//  calledFlickrBrowser
//
//  Created by Amelie on 14-3-22.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import "FavoritesTVC.h"
#import "FlickrFetcher.h"
#import "Photo.h"
#import "PhotoVC.h"
#import "UIImageResizing.h"

@interface FavoritesTVC ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation FavoritesTVC



- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    request.predicate=nil;
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];

    
    [self.tableView reloadData];
   
}





#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Favorites Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.owner;
    
    UIImage *image = [UIImage imageWithData:photo.thumbnail];
    UIImage* smallImage = [image scaleToSize:CGSizeMake(100.0f,100.0f)];
    
    cell.imageView.image=smallImage;
    [cell.imageView sizeToFit];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:managedObject];
        [self.managedObjectContext save:nil];
        [self.tableView reloadData];
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show PhotoVC"])
    {
        UITableViewCell *cell =  (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [segue.destinationViewController setPhotoURL:[NSURL URLWithString:photo.imageURL]];
        [segue.destinationViewController navigationItem].title = cell.textLabel.text;
    }
}
// In a storyboard-based application, you will often want to do a little preparation before navigation



@end
