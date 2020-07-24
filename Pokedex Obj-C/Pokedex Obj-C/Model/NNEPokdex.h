//
//  NNEPokdex.h
//  Pokedex Obj-C
//
//  Created by Nonye on 7/24/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Pokedex)

@interface NNEPokdex : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic) int identifier;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSArray *abilities;

- (instancetype)initWithName:(NSString *)name url:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
