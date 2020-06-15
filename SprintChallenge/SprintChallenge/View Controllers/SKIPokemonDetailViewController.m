//
//  SKIPokemonDetailViewController.m
//  SprintChallenge
//
//  Created by Joshua Rutkowski on 6/14/20.
//  Copyright © 2020 Ski. All rights reserved.
//

#import "SKIPokemonDetailViewController.h"
#import "SprintChallenge-Swift.h"
#import "SKIPokemon.h"

void *KVOContext = &KVOContext;

@interface SKIPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation SKIPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [PokemonAPI.sharedController addObserver:self forKeyPath:@"pokemon" options:NSKeyValueObservingOptionInitial context:KVOContext];
    [PokemonAPI.sharedController addObserver:self forKeyPath:@"pokemonImage" options:NSKeyValueObservingOptionInitial context:KVOContext];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [PokemonAPI.sharedController removeObserver:self forKeyPath:@"pokemon" context:KVOContext];
    [PokemonAPI.sharedController removeObserver:self forKeyPath:@"pokemonImage" context:KVOContext];
}

- (void) updateViews {
    
    SKIPokemon *pokemon = PokemonAPI.sharedController.pokemon;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", [pokemon.name capitalizedString]];
        self.IDLabel.text = [NSString stringWithFormat:@"ID: %i", pokemon.idenitifier];
        self.abilitiesLabel.text =  [NSString stringWithFormat:@"Abilities: %@", [pokemon.abilities capitalizedString]];
        
        self.imageView.image = PokemonAPI.sharedController.pokemonImage;
        NSLog(@"%@", pokemon.abilities);
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"pokemon"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"pokemonImage"]) {
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    PokemonAPI.sharedController.pokemon = nil;
    PokemonAPI.sharedController.pokemonImage = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
