//
//  REPPokeman.h
//  Pokedex
//
//  Created by Michael Redig on 10/18/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokeman)
@interface REPPokeman : NSObject

@property (nonatomic) NSUInteger identifier;
@property (copy, nonatomic) NSString *name;
@property (nonatomic) NSURL *pokeURL;
@property (nonatomic, nullable) UIImage *sprite;
@property (nonatomic, nullable) NSArray<NSString *> *abilities;

- (instancetype)initWithName:(NSString *)name infoURL:(NSURL *)url;

+ (REPPokeman *)pokemonFromDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
