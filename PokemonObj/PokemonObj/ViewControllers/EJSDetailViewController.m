//
//  EJSViewController.m
//  PokemonObj-CSprint
//
//  Created by Enzo Jimenez-Soto on 7/24/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import "EJSDetailViewController.h"
#import "EJSPokemon.h"
#import "PokemonObj-Swift.h"

// using address as identifier
void *KVOContext = &KVOContext;

@interface EJSDetailViewController ()

// MARK: - Outlets


@property (strong, nonatomic) IBOutlet
UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UITextView *textView;


@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;


@end

@implementation EJSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

/// Updates self.imageView and self.textView (title holds Pokemon id and name)
- (void)updateViews {
        
    if (!self.isViewLoaded) {return;}
    
    if (self.pokemon) {
        
        // ID and Name
        
        
        NSString *title = [NSString stringWithFormat:@"#%i - %@", self.pokemon.identifier.intValue, self.pokemon.name.capitalizedString];
        self.title = title;
        
        
        // Sprite
        NSURL *url = self.pokemon.sprite;
        
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"Error: %@", error);
                return;
            }
            
            if (data == nil) {
                NSLog(@"No data");
                return;
            }
            
            UIImage *image = [[UIImage alloc] initWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
            });
            
        }] resume];
        
        // Abilities
        self.textView.text = [self.pokemon.abilities  componentsJoinedByString:@"\n"];
        self.abilitiesTextView.text = (@"Abilities:");
    }
}

/// Setter
- (void)setPokemon:(EJSPokemon *)pokemon {
    
    if (pokemon != _pokemon) {
        
        _pokemon = pokemon;
        
        // add observer only when it's set
        [self.pokemon addObserver:self forKeyPath:@"identifier" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

// MARK: - KVO

/// Add observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // == compares MEMORY ADDRESSES
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"identifier"]) {
            NSLog(@"running: %@", [object valueForKeyPath:keyPath]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateViews];
            });
        }
    }
    
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

/// Remove observer
- (void)dealloc {
    
    // Stop observing KVO (otherwise it will crash randomly)
    [self.pokemon removeObserver:self forKeyPath:@"identifier" context:&KVOContext];
}

@end
