//
//  KTMPokedexTableViewController.h
//  ObjCPokedex
//
//  Created by Kobe McKee on 7/26/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTMPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface KTMPokedexTableViewController : UITableViewController

@property (nonatomic, readwrite, nullable)KTMPokemon *seguePokemon;


@end

NS_ASSUME_NONNULL_END
