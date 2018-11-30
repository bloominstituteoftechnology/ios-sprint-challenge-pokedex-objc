//
//  FAFPokemon.h
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAFPokemon : NSObject
    

    
    @property (nonatomic, strong) NSString *name;
    @property (nonatomic) NSInteger id;
    @property (nonatomic) NSInteger weight;
    @property (nonatomic, strong) NSString *imageURL;
    @property (nonatomic, strong) NSArray *abilities;
    @property (nonatomic, strong) NSArray *types;
    

@end

NS_ASSUME_NONNULL_END
