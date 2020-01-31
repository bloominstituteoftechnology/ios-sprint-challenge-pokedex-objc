//
//  PNCPokemon.h
//  Pokedex-ObjC
//
//  Created by Lambda_School_Loaner_263 on 1/31/20.
//  Copyright © 2020 Lambda_School_Loaner_263. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PNCPokemon : NSObject

@property (copy, nonnull, nonatomic) NSString *name;
@property (copy, nonnull, nonatomic) NSURL *url;
@property (copy, nonnull, nonatomic) NSNumber *pokeId;
@property (copy, nonnull, nonatomic) NSString *abilities;

- (instancetype _Nonnull)initWithDictionary:(NSDictionary *_Nonnull)dictionary;

@end


