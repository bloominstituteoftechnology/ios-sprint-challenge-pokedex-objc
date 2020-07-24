//
//  CAMPokemonDetailViewController.m
//  Pokedex
//
//  Created by Cody Morley on 7/24/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import "CAMPokemonDetailViewController.h"

@interface CAMPokemonDetailViewController ()

@end

@implementation CAMPokemonDetailViewController
//MARK: - Life Cycles -
- (void)viewDidLoad {
    [super viewDidLoad];
    _pokedex = PokedexAPIController.shared;
}



@end
