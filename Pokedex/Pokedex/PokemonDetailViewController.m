//
//  PokemonDetailViewController.m
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "Pokemon.h"
#import "Pokedex-Swift.h"

static NSString *identifier = @"identifier";

@interface PokemonDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *pokemonIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;


@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.pokemon) {
        [self.pokemon addObserver:self forKeyPath:identifier options:0 context:nil];
        [PokemonController.sharedController fillInDetailsFor:self.pokemon];
    }
}

- (void)dealloc
{
    [self.pokemon removeObserver:self forKeyPath:identifier];
}

- (void)updateViews
{
    self.pokemonNameLabel.text = [self.pokemon.name capitalizedString];
    self.pokemonIDLabel.text = [[NSString alloc] initWithFormat:@"%@", self.pokemon.identifier];

    NSString *abilitiesString = [[self.pokemon.abilites valueForKey:@"description"] componentsJoinedByString:@", "];
    self.pokemonAbilitiesLabel.text = abilitiesString;
}

@end
