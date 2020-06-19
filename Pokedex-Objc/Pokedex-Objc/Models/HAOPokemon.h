//
//  HAOPokemon.h
//  Pokedex-Objc
//
//  Created by Hunter Oppel on 6/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Pokemon)

@interface HAOPokemon : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *spriteURL;
@property (nonatomic) NSString *identifier;
@property (nonatomic) NSArray<NSString *> *abilites;

- (instancetype)initWithName:(NSString *)name;

- (void)fillInDetailsForPokemon:(HAOPokemon *)pokemon dictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
