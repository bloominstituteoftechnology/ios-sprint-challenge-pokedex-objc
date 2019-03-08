//
//  BHPokemonTemporaryResults.h
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BHPokemonTemporaryResults : NSObject

@property NSString *name;
@property NSString *moreInfoURL;

-(instancetype)initWithJSON:(id)json;

@end

NS_ASSUME_NONNULL_END
