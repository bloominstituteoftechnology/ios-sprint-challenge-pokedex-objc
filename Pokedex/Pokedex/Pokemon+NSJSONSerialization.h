//
//  Pokemon+NSJSONSerialization.h
//  Pokedex
//
//  Created by Bobby Keffury on 2/23/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon (NSJSONSerialization)

//MARK: - Initializers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
