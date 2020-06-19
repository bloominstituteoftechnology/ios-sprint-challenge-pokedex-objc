//
//  LSIDetailViewController.h
//  Pokedex
//
//  Created by Bhawnish Kumar on 6/19/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex-Swift.h"
#import "LSIPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSIDetailViewController : UIViewController

@property (nonatomic, retain) PokemonController *pokemonController;
@property (nonatomic, retain) LSIPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
