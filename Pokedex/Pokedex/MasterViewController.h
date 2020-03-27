//
//  MasterViewController.h
//  Pokedex
//
//  Created by Alexander Supe on 27.03.20.
//  Copyright © 2020 Alexander Supe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

