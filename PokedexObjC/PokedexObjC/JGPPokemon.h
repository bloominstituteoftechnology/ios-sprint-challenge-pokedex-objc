//
//  JGPPokemon.h
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGPAbility.h"

NS_SWIFT_NAME(Pokemon)
NS_ASSUME_NONNULL_BEGIN
@interface JGPPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) int identifier;                  // uh-oh, how do you nullable an int?
@property (nonatomic, copy, nullable) NSString *sprite;
@property (nonatomic, copy, nullable) NSArray<NSString *> *abilities;

// USE this when all you need is the list of Pokemon but not the attributes
// double check if initWithName can be _Nonnull here... (what if Networking fails? error in networking should take care of that, but double-check with PM
- (nonnull instancetype) initWithName:(NSString *_Nonnull)name
                           identifier:(int)identifier
                               sprite:(NSString *_Nullable)sprite
                            abilities:(NSArray<NSString *> *)abilities;
;

- (nullable instancetype)initWithDictionary:(NSDictionary *_Nullable)dict;

@end

NS_ASSUME_NONNULL_END


