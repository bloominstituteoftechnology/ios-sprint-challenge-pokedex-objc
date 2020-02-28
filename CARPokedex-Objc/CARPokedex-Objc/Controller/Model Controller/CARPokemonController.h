//
//  CARPokemonController.h
//  CARPokedex-Objc
//
//  Created by Chad Rutherford on 2/28/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CARPokemon.h"

@interface CARPokemonController : NSObject

@property (nonatomic, readonly, nonnull) NSArray<CARPokemon *> *pokemon;

- (void)addPokemonFromArray:(NSArray<CARPokemon*> *_Nonnull)pokemon;

@end
