//
//  MBMPokemon.h
//  Pokedex
//
//  Created by Michael on 3/27/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBMPokemon : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSURL *url;

- (instancetype)initWithName:(NSString *)name
                         url:(NSURL *)url;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
