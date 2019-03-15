//
//  LSIPokemon.h
//  Pokedex-ObjC
//
//  Created by Iyin Raphael on 3/15/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIPokemon : NSObject

-(instancetype) initWithPokemonName:(NSString *)name url:(NSString *)url;
-(instancetype) initWithDictionary: (NSDictionary *)dictionary;

-(void) abilitiesArray: (NSArray *) array;

@property NSString *name;
@property (nonatomic, nullable) NSString *abilities;
@property (nonatomic, nullable) NSString *sprite;
@property (nonatomic, nullable) NSString *id;
@property NSString *url;

@end

NS_ASSUME_NONNULL_END
