//
//  MSKPokemonDetailViewController.h
//  NotDigimonObjectiveC
//
//  Created by Lambda_School_Loaner_268 on 5/23/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSKPokemon.h"
@class PokemonAPI;
NS_ASSUME_NONNULL_BEGIN

@interface MSKPokemonDetailViewController : UIViewController
@property (nonatomic, assign) MSKPokemon *pokemon;
@property (nonatomic, assign) PokemonAPI *controller;
@end

NS_ASSUME_NONNULL_END
