//
//  Pokemon.h
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Pokemon)

@interface Pokemon : NSObject

@property NSString *name;
@property NSString *identifier;
@property NSArray<NSString *> *abilites;
@property NSURL *spriteURL;

- (instancetype)initWithName:(NSString *)name;

- (void)fillInDetailsForPokemon:(Pokemon *)pokemon dictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
