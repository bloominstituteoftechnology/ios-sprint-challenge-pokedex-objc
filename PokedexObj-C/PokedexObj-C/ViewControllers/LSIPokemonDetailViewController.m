//
//  LSIPokemonDetailViewController.m
//  PokedexObj-C
//
//  Created by James McDougall on 3/5/21.
//

#import "LSIPokemonDetailViewController.h"

//MARK: - Interface -
@interface LSIPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstAbilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondAbilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdAbilityLabel;

- (void)fetchPokemonDetails;
- (void)fetchImage;

@end


//MARK: - Implementation -
@implementation LSIPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_pokemon addObserver:self forKeyPath: @"spriteURL"    options:0 context:nil];
    [_pokemon addObserver:self forKeyPath: @"identifier"   options:0 context:nil];
    [_pokemon addObserver:self forKeyPath: @"abilities" options:0 context:nil];
    
    [self fetchPokemonDetails];
}

- (void)fetchImage {
    [[NSURLSession.sharedSession dataTaskWithURL:_pokemon.spriteURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"ERROR: Error occured while fetching pokemon image, reason: %@", error);
            return;
        }
        if (!data) {
            NSLog(@"ERROR: Data not found while requesting pokemon image, reason: %@", error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [[UIImage alloc] initWithData:data];
            self->_imageView.image = image;
        });
        
    }]resume];
    
    return;
}

- (void)fetchPokemonDetails {
    _nameLabel.text = _pokemon.name;
    [PokemonAPI.sharedController fillInDetailsFor: _pokemon];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(LSIPokemon*)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"spriteURL"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self fetchImage];
        });
    }
    
    else if ([keyPath isEqualToString:@"identifier"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_idLabel.hidden = false;
            self->_idLabel.text = [self->_pokemon.identifier stringValue];
        });
    }
    
    if ([keyPath isEqualToString:@"abilities"]) {
        
        if (_pokemon.abilities.count > 2) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_thirdAbilityLabel.hidden = false;
                self->_thirdAbilityLabel.text = self->_pokemon.abilities[2];
            });
            return;
        }
        
        if (_pokemon.abilities.count > 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_secondAbilityLabel.hidden = false;
                self->_secondAbilityLabel.text = self->_pokemon.abilities[1];
            });
            return;
        }
        
        if (_pokemon.abilities.count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_firstAbilityLabel.hidden = false;
                self->_firstAbilityLabel.text = self->_pokemon.abilities[0];
            });
            return;
        }
        
    } //End of top level if-statement for abilities
    
} //End of observing method

@end

