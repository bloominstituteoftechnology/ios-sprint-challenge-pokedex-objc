//
//  NELPokemon.h
//  Pokedex
//
//  Created by Nelson Gonzalez on 4/5/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NELPokemon : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(void)fillPokeDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *pokeName;
@property (nonatomic, copy, readonly) NSURL *pokeUrl;
@property (nonatomic, readonly) NSNumber *pokeId;
@property (nonatomic, copy, readonly, nullable) NSURL *pokeFrontDefaultUrl;
@property (nonatomic, copy, nullable) NSArray<NSString *> *pokeAbilities;

@end

NS_ASSUME_NONNULL_END
