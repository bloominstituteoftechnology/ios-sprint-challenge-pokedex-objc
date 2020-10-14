//
//  PokemonDetailViewController.m
//  Pokedex
//
//  Created by Elizabeth Thomas on 10/13/20.
//

#import "PokemonDetailViewController.h"
#import "Pokemon.h"
#import "Pokedex-Swift.h"

static NSString *identifier = @"identifier";
void *KVOContext = &KVOContext;

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
        [self updateViews];
        [PokemonController.sharedController fillInDetailsFor:self.pokemon];
        [self.pokemon addObserver:self forKeyPath:identifier options:0 context:KVOContext];
    }
}

- (void)updateViews
{
    self.pokemonNameLabel.text = self.pokemon.name;
    self.pokemonIDLabel.text = [NSString stringWithFormat:@"%@", self.pokemon.identifier];
    self.pokemonAbilitiesLabel.text = [self.pokemon.abilities componentsJoinedByString:@", "];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
            [self updateImage];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateImage
{
    [PokemonController.sharedController fetchImageAt:self.pokemon.spriteURLString completion:^(UIImage * _Nullable image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];
}

- (void)dealloc
{
    [self.pokemon removeObserver:self forKeyPath:identifier context:KVOContext];
}

@end
