//
//  IIIPokemonDetailViewController.h
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex_Objc_Swift-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@class IIIPokemon;

@interface IIIPokemonDetailViewController : UIViewController

@property (nonatomic, nullable, readwrite) IIIPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
