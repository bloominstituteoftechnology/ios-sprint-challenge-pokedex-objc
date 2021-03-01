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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak, nonatomic) IBOutlet UILabel *pokemonID;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbility;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews
{
    
    [PokemonController.sharedController pokemonResultWith:_pokemon];
   // [NSString stringWithFormat:@" %@",]
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self->_pokemonName.text =  self->_pokemon.name.capitalizedString;
        
        self->_pokemonID.text = [NSString stringWithFormat:@" %@", self->_pokemon.identifier];
        
        NSArray<NSString *> *abilityArray = [self->_pokemon.abilities componentsSeparatedByString:@", "];
        NSString *ability = [abilityArray componentsJoinedByString:@"\n"];
        self->_pokemonAbility.text = ability;
        
        [PokemonController.sharedController fetchImageWithCompletion:^(UIImage *image, NSError *error) {
            if (error) {
                NSLog(@"Error loading image");
            }
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.pokemonImageView.image = image;
                    NSLog(@"Words: %@", self->_pokemon.sprites);
                });
            }
        }];
    });
}


@end
