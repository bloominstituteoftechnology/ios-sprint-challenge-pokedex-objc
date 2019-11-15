//
//  ARPokemon.h
//  PokedexObjc
//
//  Created by Alex Rhodes on 11/15/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ARPokemon : NSObject

@property (nonatomic, copy, readonly)NSString *name;
@property (nonatomic, copy, readonly)NSArray <NSString *> *abilities;
@property NSNumber *ID;
@property NSURL *sprite;


- (instancetype) initWithName:(NSString *)name abilities:(NSArray <NSString *>*)abilities ID:(NSNumber *)ID sprite:(NSURL *)sprite;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

