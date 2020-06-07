//
//  OTKPokedexTableViewController.h
//  Pokedex
//
//  Created by Tobi Kuyoro on 22/05/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APIController;

NS_ASSUME_NONNULL_BEGIN

@interface OTKPokedexTableViewController : UITableViewController

@property (nonatomic) APIController *apiController;

@end

NS_ASSUME_NONNULL_END
