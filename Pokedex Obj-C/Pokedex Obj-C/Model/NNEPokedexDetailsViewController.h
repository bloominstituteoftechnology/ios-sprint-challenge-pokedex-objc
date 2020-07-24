//
//  NNEPokedexDetailsViewController.h
//  Pokedex Obj-C
//
//  Created by Nonye on 7/24/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokedex_Obj_C-Swift.h"
#import "NNEPokdex.h"

NS_ASSUME_NONNULL_BEGIN

@interface NNEPokedexDetailsViewController : UIViewController

@property (nonatomic, assign) PokedexController *pokedexController;
@property (nonatomic, assign) NNEPokdex *pokemon;

@end

NS_ASSUME_NONNULL_END
