//
//  DetailVC.m
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

#import "DetailVC.h"
#import "Pokemon.h"
#import "Pokedex-Swift.h"

void *KVOContext = &KVOContext;

@interface DetailVC ()

@property (nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) IBOutlet UILabel *identifierLabel;
@property (nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_pokemon addObserver:self
               forKeyPath:@"spriteURL"
                  options:0
                  context:KVOContext];
    [self updateViews];
}

- (void)updateViews
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self->_nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.pokemon.name.capitalizedString];
        if (self.pokemon.identifier) {
            self->_identifierLabel.text = [NSString stringWithFormat:@"Identifier: %@", self.pokemon.identifier];
        }
        if (self.pokemon.abilities) {
            NSArray<NSString *> *abilityArray = [self.pokemon.abilities componentsSeparatedByString:@", "];
            NSString *abilityString = [abilityArray componentsJoinedByString:@"\n"];
            self->_abilitiesTextView.text = abilityString;
        }
        if (![self.pokemon.spriteURL isEqual:@""]) {
            NSURL *url = [NSURL URLWithString:self.pokemon.spriteURL];
            [PokemonAPI.sharedController fetchImageWithUrl:url completion:^(UIImage *image, NSError *error) {
                if (error) {
                    NSLog(@"Error fetching image: \(error)");
                }
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.imageView.image = image;
                    });
                }
            }];
        }
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
    
    if ([keyPath isEqualToString:@"spriteURL"]) {
        [self updateViews];
    }
}

- (void)dealloc
{
    [_pokemon removeObserver:self
                  forKeyPath:@"spriteURL"
                     context:KVOContext];
}

@end
