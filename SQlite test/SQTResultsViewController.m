//
//  SQTResultsViewController.m
//  SQlite test
//
//  Created by Andrew Chernyhov on 28.09.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "SQTResultsViewController.h"

@interface SQTResultsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *arrayOfEntries;

- (NSString *) filePath;
- (void) openDB;

@end

@implementation SQTResultsViewController

- (NSString *) filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [paths [0] stringByAppendingPathComponent:@"DB.sql"];
}


- (void) openDB {
    
    if (sqlite3_open([self.filePath UTF8String], &_DB) != SQLITE_OK) {
        sqlite3_close(self.DB);
        NSAssert(0, @"Database failed to open");
    } else {
        
        NSLog(@"Database opened succefully");
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayOfEntries = [NSMutableArray new];
    [self openDB];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM summary"];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(self.DB, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) ==SQLITE_ROW) {
            char *field1 = (char *) sqlite3_column_text(statement, 0);
            NSString *field1Str = [[NSString alloc] initWithUTF8String:field1];
            
            char *field2 = (char *) sqlite3_column_text(statement, 1);
            NSString *field2Str = [[NSString alloc] initWithUTF8String:field2];
            
            char *field3 = (char *) sqlite3_column_text(statement, 2);
            NSString *field3Str = [[NSString alloc] initWithUTF8String:field3];
            
            
            char *field4 = (char *) sqlite3_column_text(statement, 3);
            NSString *field4Str = [[NSString alloc] initWithUTF8String:field4];
            
            NSString *str = [[NSString alloc] initWithFormat:@"%@/%@ - %@", field2Str, field3Str, field4Str];
            
            [self.arrayOfEntries addObject:str];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.arrayOfEntries count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = self.arrayOfEntries [indexPath.row];
    
    return cell;
}

@end
