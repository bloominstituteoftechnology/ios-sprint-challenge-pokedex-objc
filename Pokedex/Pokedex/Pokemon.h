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

@property (nonatomic) NSString *name;
@property (nonatomic) NSNumber *identifier;
@property (nonatomic) NSArray<NSString *> *abilites;
@property (nonatomic) NSURL *spriteURL;

- (instancetype)initWithName:(NSString *)name;

- (void)fillInDetailsForPokemon:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
