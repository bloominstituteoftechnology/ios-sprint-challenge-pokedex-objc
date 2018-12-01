//
//  FAFDetailViewController.h
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAFPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAFDetailViewController : UIViewController
    
@property (nonatomic, weak) FAFPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
