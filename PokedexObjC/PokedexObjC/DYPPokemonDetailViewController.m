//
//  DYPPokemonDetailViewController.m
//  PokedexObjC
//
//  Created by Daniela Parra on 11/30/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

#import "DYPPokemonDetailViewController.h"

//void *KVOContext = &KVOContext;

@interface DYPPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation DYPPokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews
{
    if (self.pokemon) {
        
        [self imageFromURL:self.pokemon.sprite completionBlock:^(UIImage *image, NSError *error) {
            if (error) {
                //nslog
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.imageView setImage:image];
            });
        }];
        NSString *name = self.pokemon.name;
        [self.nameLabel setText:name];
        NSString *identifer = [self.pokemon.identifier stringValue];
        [self.idLabel setText:identifer];
        NSString *abilities = self.pokemon.abilities;
        [self.abilitiesTextView setText:abilities];
        
    }
}

- (void)imageFromURL:(NSURL *)url completionBlock:(void (^)(UIImage *image, NSError *error))completion
{
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching image from URL: %@", error);
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSLog(@"No data returned from data task");
            completion(nil, [[NSError alloc] init]);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image, nil);
        
    }] resume];
}

- (void)setPokemon:(DYPPokemon *)pokemon
{
    if (pokemon != _pokemon) {
    
        _pokemon = pokemon;
    
        [self updateViews];
    }
}

@end
