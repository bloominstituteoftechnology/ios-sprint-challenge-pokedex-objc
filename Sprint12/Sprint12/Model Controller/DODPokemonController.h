//
//  DODPokemonController.h
//  Sprint12
//
//  Created by David Doswell on 10/12/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DODPokemon;
@interface DODPokemonController : NSObject

- (void)fetchPokemonWithName:(NSString *)name completion:(void (^)(DODPokemon * _Nullable abilities, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
