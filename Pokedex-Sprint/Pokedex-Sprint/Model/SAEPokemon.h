//
//  SAEPokemon.h
//  Pokedex-Sprint
//
//  Created by Sammy Alvarado on 12/14/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAEPokemon : NSObject

@property (nonatomic, nullable, copy) NSString *name;
@property (nonatomic, nullable) NSMutableArray <NSString *> *abilities;
@property (nonatomic, nonnull) NSNumber *identifier;
@property (nonatomic, nullable) NSURL *sprite;
@property (nonatomic, nonnull) NSURL *pokemonURL;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
