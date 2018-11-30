//
//  IIIPokemonDetailViewController.h
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class IIIPokemon;
@class IIIPokemonController;

@interface IIIPokemonDetailViewController : UIViewController

@property (nonatomic, nullable, readwrite) IIIPokemon *pokemon;
@property (nonatomic, nullable, readwrite) IIIPokemonController *pokemonController;

@end

NS_ASSUME_NONNULL_END
