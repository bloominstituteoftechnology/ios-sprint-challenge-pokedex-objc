//
//  BRMPokemonDetailViewController.m
//  Pokedex
//
//  Created by Bronson Mullens on 10/9/20.
//

#import "Pokedex-Swift.h"
#import "BRMPokemonDetailViewController.h"
#import "BRMPokemon.h"

void *KVOContext = &KVOContext;

@interface BRMPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonSpriteView;
@property (weak, nonatomic) IBOutlet UILabel *pokeonIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;

@end

@implementation BRMPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonAPI.sharedController addObserver:self forKeyPath:@"pokemon" options:NSKeyValueObservingOptionInitial context:KVOContext];
    [PokemonAPI.sharedController addObserver:self forKeyPath:@"pokemonSprite" options:NSKeyValueObservingOptionInitial context:KVOContext];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    [PokemonAPI.sharedController removeObserver:self forKeyPath:@"pokemon" context:KVOContext];
    [PokemonAPI.sharedController removeObserver:self forKeyPath:@"pokemonSprite" context:KVOContext];
}

- (void)updateViews {
    BRMPokemon *pokemon = PokemonAPI.sharedController.pokemon;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.title = pokemon.name.capitalizedString;
        self.pokeonIDLabel.text = [NSString stringWithFormat:@"ID: %i", pokemon.identifier];
        self.pokemonAbilitiesLabel.text = [NSString stringWithFormat:@"Abilities:\n%@", pokemon.abilities.capitalizedString];
        self.pokemonSpriteView.image = PokemonAPI.sharedController.pokemonSprite;
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"pokemon"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"pokemonSprite"]) {
            [self updateViews];
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}

- (void)dealloc {
    PokemonAPI.sharedController.pokemon = nil;
    PokemonAPI.sharedController.pokemonSprite = nil;
}

- (IBAction)onlineButtonTapped:(id)sender {
    BRMPokemon *pokemon = PokemonAPI.sharedController.pokemon;
    NSURL *url = [NSURL URLWithString:@"https://pokemondb.net/pokedex/"];
    NSURL *fullURL = [url URLByAppendingPathComponent:pokemon.name];
    
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:fullURL options:@{} completionHandler:nil];
}

@end
