//
//  DMOPokemonDetailViewController.m
//  Week15SprintChallenge
//
//  Created by morse on 1/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "DMOPokemonDetailViewController.h"
#import "DMOPokemon.h"
#import "Week15SprintChallenge-Swift.h"

void *KVOContext = &KVOContext;

@interface DMOPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation DMOPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonAPI.sharedController addObserver:self forKeyPath:@"pokemon" options:NSKeyValueObservingOptionInitial context:KVOContext];
}

- (void)viewDidDisappear:(BOOL)animated {
[super viewDidDisappear:animated];

[PokemonAPI.sharedController removeObserver:self forKeyPath:@"pokemon" context:KVOContext];
}

- (void) updateViews {
    
    DMOPokemon *pokemon = PokemonAPI.sharedController.pokemon;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", [pokemon.name capitalizedString]];
        self.idLabel.text = [NSString stringWithFormat:@"ID: %i", pokemon.idenitifier];
        self.abilitiesLabel.text =  [NSString stringWithFormat:@"Abilities:\n\n%@", [pokemon.abilities capitalizedString]];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"pokemon"]) {
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
