//
//  CKPokemonDetailViewController.h
//  PokeDex-ObjC
//
//  Created by Christy Hicks on 6/14/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokeDex_ObjC-Swift.h"
#import "CKPokemon.h"


NS_ASSUME_NONNULL_BEGIN

@interface CKPokemonDetailViewController : UIViewController

@property (nonatomic, assign) CKPokemonController *pokemonController;
@property (nonatomic, assign) CKPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
