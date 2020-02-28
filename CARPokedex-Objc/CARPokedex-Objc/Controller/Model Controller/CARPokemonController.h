//
//  CARPokemonController.h
//  CARPokedex-Objc
//
//  Created by Chad Rutherford on 2/28/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CARListPokemon.h"

@interface CARPokemonController : NSObject

@property (nonatomic, readonly, nonnull) NSArray<CARListPokemon *> *pokemon;

- (void)addPokemonFromArray:(NSArray<CARListPokemon*> *_Nonnull)pokemon;

@end
