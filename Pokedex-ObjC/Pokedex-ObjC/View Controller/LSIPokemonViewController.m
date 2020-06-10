//
//  LSIPokemonViewController.m
//  Pokedex-ObjC
//
//  Created by Iyin Raphael on 3/15/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

#import "LSIPokemonViewController.h"
#import "LSIPokemon.h"
#import "Pokedex_ObjC-Swift.h"


@interface LSIPokemonViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@property PokemonGET *network;

@end

@implementation LSIPokemonViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.pokemon addObserver:self forKeyPath:@"sprite" options:0 context:NULL];
    _network = [[PokemonGET alloc] init];
    [self.network fetchDetailsFor:self.pokemon];
}

-(void) updateView {
    if (![self.pokemon name] && ![self isViewLoaded]) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTitle:self.pokemon.name];
        self.nameLabel.text = self.pokemon.name;
        self.abilitiesLabel.text = [self.pokemon abilities];
        self.idLabel.text =[self.pokemon id];
        [self loadImageWithString: [self.pokemon sprite]];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    [self updateView];
    NSLog(@"ID %@", [object valueForKeyPath:@"abilities"]);
    
}


-(void) loadImageWithString: (NSString *) fileName{
    
    NSURL *url = [NSURL URLWithString: fileName];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error){
            NSLog(@"Error with image loading: %@", error);
        }
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self imageView] setImage:image];
        });
        
    }] resume];
    
}

@end
