//
//  PokedexTVC.m
//  ObjCPokedex
//
//  Created by Shawn James on 6/19/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

#import "PokedexTVC.h"
#import "ObjCPokedex-Swift.h"
#import "SDJPokemon.h"

@interface PokedexTVC ()

@property (nonatomic) SDJNetworkController *networkController;
@property (nonatomic, copy) NSArray<SDJPokemon *> *pokemon;

@end

@implementation PokedexTVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
