//
//  LSIPokedexTableViewController.h
//  Pokedex ObjC
//
//  Created by macbook on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PokemonAPI;

@interface LSIPokedexTableViewController : UITableViewController

@property (nonatomic) PokemonAPI *pokemonAPI;

@end

