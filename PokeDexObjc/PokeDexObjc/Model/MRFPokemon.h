//
//  MRFPokemon.h
//  PokeDexObjc
//
//  Created by Michael Flowers on 7/26/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRFPokemon : NSObject
@property (atomic, readonly) NSString *name;
@property (atomic, readonly) int identifier;
@property (atomic, readonly) NSString *sprite;
@property (atomic, readonly) NSArray< NSString *> *abilities;
@end

NS_ASSUME_NONNULL_END
