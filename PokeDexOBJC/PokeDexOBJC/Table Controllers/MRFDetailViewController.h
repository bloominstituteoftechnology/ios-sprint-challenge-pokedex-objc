//
//  MRFDetailViewController.h
//  PokeDexOBJC
//
//  Created by Michael Flowers on 11/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRFPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface MRFDetailViewController : UIViewController

@property (nonatomic) MRFNetwork *network;
@property (nonatomic) MRFPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
