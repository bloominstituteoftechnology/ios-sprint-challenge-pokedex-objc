//
//  ViewController.m
//  ObjCPokedex
//
//  Created by Craig Belinfante on 2/22/21.
//

#import "ViewController.h"
#import "Pokemon.h"
#import "ObjCPokedex-Bridging-Header.h"
#import "ObjCPokedex-Swift.h"

void *KVOContext = &KVOContext;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak, nonatomic) IBOutlet UILabel *pokemonID;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbility;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_pokemon addObserver:self
               forKeyPath:@"name"
                  options:0
                  context:KVOContext];
    [self updateViews];
}

- (void)updateViews
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self->_pokemonName.text =  self->_pokemon.name.capitalizedString;
        
        if (self.pokemon.identifier != nil) {
            self->_pokemonID.text = [NSString stringWithFormat:@"%@", self->_pokemon.identifier];
        }
        
        if (self.pokemon.abilities) {
            NSArray<NSString *> *abilityArray = [self->_pokemon.abilities componentsSeparatedByString:@", "];
            NSString *ability = [abilityArray componentsJoinedByString:@"\n"];
            self->_pokemonAbility.text = ability;
        }
        
        NSString *spritesString = @"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/";
        NSString *appendString = self->_pokemonID.text;
        NSString *urlString = [NSString stringWithFormat:@"%@%@", spritesString, appendString];
        urlString = [urlString stringByAppendingString:@".png"];
        NSURL *url = [NSURL URLWithString: urlString];
        
        [PokemonController.sharedController fetchImageWithUrl:url completion:^(UIImage *image, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            }
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.pokemonImageView.image = image;
                });
                
            }
        }];
    });
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if (context != KVOContext) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if ([keyPath isEqualToString:@"name"]) {
        [self updateViews];
    }
}

- (void)dealloc
{
    [_pokemon removeObserver:self
                  forKeyPath:@"name"
                     context:KVOContext];
}


@end
