//
//  JGPPokemon.h
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGPAbility.h"



@interface JGPPokemon : NSObject

@property (nonatomic, copy, nonnull) NSString *name;
@property (nonatomic, readonly, nullable) int *id;
@property (nonatomic, readonly, nullable) NSString *sprite;
@property (nonatomic, readonly, nullable) NSArray<JGPAbility *> *abilities;

// USE this when all you need is the list of Pokemon but not the attributes
// double check if initWithName can be _Nonnull here... (what if Networking fails? error in networking should take care of that, but double-check with PM
- (nonnull instancetype) initWithName:(NSString *_Nonnull)name;

- (nullable instancetype)initWithDictionary:(NSDictionary *_Nullable)dict;

@end


