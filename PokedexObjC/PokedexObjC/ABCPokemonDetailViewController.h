//
//  ABCPokemonDetailViewController.h
//  PokedexObjC
//
//  Created by Austin Cole on 3/8/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABCPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABCPokemonDetailViewController : UIViewController

@property ABCPokemon *pokemon;

@property (weak, nonatomic) IBOutlet UIImageView *pokemonSpriteImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonFirstAbilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonSecondAbilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonThirdAbilityLabel;



@end

NS_ASSUME_NONNULL_END
