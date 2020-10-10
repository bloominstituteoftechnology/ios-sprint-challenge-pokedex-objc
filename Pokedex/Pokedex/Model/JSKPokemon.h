//
//  JSKPokemon.h
//  Pokedex
//
//  Created by Josh Kocsis on 10/9/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSKPokemon : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) int pokemonID;
@property (nonatomic, readonly) NSArray<NSString *> *abilities;
@property (nonatomic, readonly) NSString *sprite;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWIthName:(NSString *)name pokemonID:(int)pokemonID abilities:(NSArray *)abilities sprite:(NSString *)sprite;

@end

NS_ASSUME_NONNULL_END
