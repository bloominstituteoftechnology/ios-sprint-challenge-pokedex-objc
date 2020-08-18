//
//  XMPPokedexDetailViewController.m
//  pokedex-objc
//
//  Created by conner on 8/14/20.
//  Copyright © 2020 conner. All rights reserved.
//

#import "XMPPokedexDetailViewController.h"
#import "pokedex_objc-Swift.h"

@interface XMPPokedexDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstAbilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondAbilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdAbilityLabel;
@end

@implementation XMPPokedexDetailViewController

-(void)updateViews {
    // Name, ID, Image
    _nameLabel.text = [_pokemon.name capitalizedString];
    _idLabel.text = [[NSString alloc] initWithFormat:@"ID: %lu", (unsigned long)_pokemon.identifier];
    _imageView.image = _pokemon.image;
    // Abilities
    UILabel* abilityLabels[] = { _firstAbilityLabel, _secondAbilityLabel, _thirdAbilityLabel };
    int iteration = 0;
    for(NSString* ability in _pokemon.abilities) {
        abilityLabels[iteration].text = ability;
        iteration++;
    }
}

-(void)startMonitoringPokemon {
    //[_pokemon addObserver:self forKeyPath:@"identifier" options:0 context:NULL];
    //[_pokemon addObserver:self forKeyPath:@"abilities" options:0 context:NULL];
    [_pokemon addObserver:self forKeyPath:@"image" options:0 context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self updateViews];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startMonitoringPokemon];
    PokemonAPI *fetcher = [PokemonAPI new];
    [fetcher fillInDetailsFor:_pokemon];
}

@end
