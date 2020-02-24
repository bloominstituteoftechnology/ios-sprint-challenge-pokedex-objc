//
//  PokemonDetailViewController.h
//  Pokedex
//
//  Created by Bobby Keffury on 2/24/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex-Swift.h"


NS_ASSUME_NONNULL_BEGIN

@interface PokemonDetailViewController : UIViewController

//MARK: - Properties

@property (nonatomic, copy) PokemonController *pokemonController;
@property (nonatomic, copy) Pokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
