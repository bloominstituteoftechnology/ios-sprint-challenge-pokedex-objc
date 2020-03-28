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

@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *detailURL;
@property (nonatomic) NSNumber *_Nullable identifier;
@property (nonatomic) NSArray *_Nullable ability;
@property (nonatomic) NSURL * _Nullable frontImage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (MBMPokemon *)updateWithDictionary:(NSDictionary *)dictionary
                             pokemon:(MBMPokemon *)pokemon;
                     

@end

NS_ASSUME_NONNULL_END
