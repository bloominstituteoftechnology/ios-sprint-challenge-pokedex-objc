//
//  OSIPokemon.h
//  Sprint12
//
//  Created by Sergey Osipyan on 3/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSIAbility.h"



NS_ASSUME_NONNULL_BEGIN


@interface OSIPokemon : NSObject
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *speciesName;
@property (nonatomic, readonly) NSArray<OSIAbility *> *abilities;
@property NSURL *imageURL;
@property (nonatomic, copy, readonly) NSURL *url;
@property (readwrite, nullable) NSString *identifier;
@property (nonatomic, readonly) NSArray<NSString *> *moves;

- (instancetype)initWithJSON:(id)json;

@end


NS_ASSUME_NONNULL_END

//class PokemonAPI: NSObject {
//
//    @objc(sharedController) static let shared: PokemonAPI
//
//    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void)
//
//    @objc func fillInDetails(for pokemon: LSIPokemon)
//}
