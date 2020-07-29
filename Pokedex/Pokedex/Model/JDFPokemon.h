//
//  JDFPokemon.h
//  Pokedex
//
//  Created by Jonathan Ferrer on 7/26/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JDFPokemon : NSObject

- (instancetype _Nullable)initWithDictionary: (NSDictionary<NSString *, NSString *> *_Nullable)dictionary;

- (void)fillInWithDictionary: (NSDictionary *_Nullable)dictionary;

@property (readonly, nonnull, copy) NSString *name;
@property (readonly, nonnull, copy) NSURL *url;
@property (readonly, nullable, copy) NSString *identifier;
@property (readonly, nullable, copy) NSURL *spriteURL;
@property (readonly, nullable, copy) NSArray<NSString *> *abilities;
@property (readonly, nonnull, copy) NSString *abilityString;

@end



