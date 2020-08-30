//
//  PokeListTableViewController.m
//  PokeDex-OBJC
//
//  Created by Joe on 8/16/20.
//  Copyright © 2020 AlphaGradeINC. All rights reserved.
//

#import "PokeListTableViewController.h"
#import "PokemonController.h"
#import "PokeDex_OBJC-Swift.h"

@interface PokeListTableViewController ()

@end

@implementation PokeListTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _networkController = [[NetworkController alloc] init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_networkController fetchPokemonWithCompletion:^(NSError *error) {
        
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
             });
    }

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _networkController.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    
    NSString *pokemon = self.networkController.list[indexPath.row];
    NSLog(@"%@", pokemon);
    cell.textLabel.text = pokemon;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
