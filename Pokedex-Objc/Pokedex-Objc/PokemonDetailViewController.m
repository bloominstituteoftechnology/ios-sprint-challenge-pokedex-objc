//
//  PokemonDetailViewController.m
//  Pokedex-Objc
//
//  Created by Joel Groomer on 2/22/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

#import "PokemonDetailViewController.h"

@interface PokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblPokemonID;
@property (weak, nonatomic) IBOutlet UIImageView *imgPokemonSprite;
@property (weak, nonatomic) IBOutlet UILabel *lblPokemonName;
@property (weak, nonatomic) IBOutlet UITextView *txtvAbilities;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews
{
    
}
@end
