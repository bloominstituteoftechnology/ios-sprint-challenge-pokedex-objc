//
//  JACPokemonDetailViewController.m
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 11/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

#import "JACPokemonDetailViewController.h"
#import "Pokedex_Objc-Swift.h"
#import "JACPokemon.h"

@interface JACPokemonDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;

@end

@implementation JACPokemonDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateViews) name:@"pokemonDetailsSet" object:nil];
}

- (void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.idLabel.text = [NSString stringWithFormat:@"%@", self.pokemon.identifier];
        self.title = self.pokemon.name;
        NSString *abilities = [NSString stringWithFormat:@"Abilities:"];
        for (NSString *ability in self.pokemon.abilities) {
            abilities = [NSString stringWithFormat:@"%@\n%@", abilities, ability];
        }
        self.abilitiesLabel.text = abilities;
        self.pokemonImageView.image = self.pokemon.image;
    });
}

@end
