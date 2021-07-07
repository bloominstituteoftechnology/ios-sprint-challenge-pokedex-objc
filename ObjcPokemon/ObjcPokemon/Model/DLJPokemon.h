//
//  DLJPokemon.h
//  ObjcPokemon
//
//  Created by Diante Lewis-Jolley on 7/26/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLJPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic) NSInteger *pokemonID;
@property (nonatomic, copy, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, copy, nullable) NSString *sprite;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;



@end

NS_ASSUME_NONNULL_END
