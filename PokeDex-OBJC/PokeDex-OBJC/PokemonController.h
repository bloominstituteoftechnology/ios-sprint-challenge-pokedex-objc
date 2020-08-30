//
//  PokemonController.h
//  PokeDex-OBJC
//
//  Created by Joe on 8/16/20.
//  Copyright © 2020 AlphaGradeINC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokemonController : NSObject

@property (nonatomic) NSArray<Pokemon *> *pokemon;

@end

NS_ASSUME_NONNULL_END
