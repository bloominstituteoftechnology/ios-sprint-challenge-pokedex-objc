//
//  JLADetailViewController.m
//  PokedexSprint
//
//  Created by Jorge Alvarez on 3/27/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLADetailViewController.h"
#import "JLAPokemon.h"
#import "PokedexSprint-Swift.h"

@interface JLADetailViewController ()

// MARK: - Outlets

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation JLADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
    self.textView.text = @"testing";
}

- (void)updateViews {
    
    NSLog(@"updateViews");
    
    if (!self.isViewLoaded) {return;}
    
    if (self.pokemon) {
    
        // TODO: add #self.pokemon.identifier -
        NSString *title = [NSString stringWithFormat:@"%@", self.pokemon.name.capitalizedString];
        self.title = title;
        
        NSURL *url = self.pokemon.sprite;
        NSLog(@"url = %@", url);
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"Error: %@", error);
                    return;
                }
                // TODO: data is nil
        //        NSData -> UIImage
                UIImage *image = [[UIImage alloc] initWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Image: %@", NSStringFromCGSize(image.size));
                    self.imageView.image = image;
                });
            }] resume];
    }
}

- (void)setPokemon:(JLAPokemon *)pokemon {
   
    if (pokemon != _pokemon) {
        
        _pokemon = pokemon;
    }
}

@end
