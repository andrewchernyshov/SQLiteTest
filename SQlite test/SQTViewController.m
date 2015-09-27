//
//  SQTViewController.m
//  SQlite test
//
//  Created by Andrew Chernyhov on 27.09.15.
//  Copyright (c) 2015 Andrew Chernyshov. All rights reserved.
//

#import "SQTViewController.h"

@interface SQTViewController ()

@property (nonatomic, weak) IBOutlet UITextField *systolicTextField;
@property (nonatomic, weak) IBOutlet UITextField *diastolicTxtField;
@property (nonatomic, weak) IBOutlet UITextField *commecntsTextField;
@property (nonatomic, readonly) NSDate *currentDate;

- (NSString *) filePath;
- (void) openDB;

- (void) createTable:(NSString *)tableName
          withField1:(NSString *)field1
          withField2:(NSString *)field2
          withField3:(NSString *)field3
          withField4:(NSString *)field4;


- (IBAction)saveDataToDB:(id)sender;
- (IBAction)loadDataFromDB:(id)sender;

@end

@implementation SQTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self openDB];
    [self createTable:@"summary" withField1:@"date" withField2:@"systolic" withField3:@"diastolic" withField4:@"comments"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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

- (void) createTable:(NSString *)tableName
          withField1:(NSString *)field1
          withField2:(NSString *)field2
          withField3:(NSString *)field3
          withField4:(NSString *)field4 {
    
    char *err;
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' SERIAL, '%@' INTEGER, '%@' INTEGER, '%@' TEXT); ", tableName, field1, field2, field3, field4];
    if (sqlite3_exec(self.DB, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(self.DB);
        NSAssert(0, @"Failed to create table");
    } else {
        NSLog(@"Table has been succefully created");
    }
    
}

- (IBAction)saveDataToDB:(id)sender {
    
    int systolic = [self.systolicTextField.text intValue];
    int diastolic = [self.diastolicTxtField.text intValue];
    NSString *comments = self.commecntsTextField.text;
    NSDate *date = [NSDate date];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO summary ('date', 'systolic', 'diastolic', 'comments') VALUES ('%@', '%d', '%d', '%@')", date, systolic, diastolic, comments];
    
    char *err;
    
    if (sqlite3_exec(self.DB, [sql UTF8String], NULL, NULL, &err) !=SQLITE_OK) {
        sqlite3_close(self.DB);
        NSAssert(0, @"Failed to update table");
    } else {
        NSLog(@"Table has been succefully updated");
    }
    
    self.systolicTextField.text = @"";
    self.diastolicTxtField.text = @"";
    self.commecntsTextField.text = @"";
    
}
- (IBAction)loadDataFromDB:(id)sender {
    
}

@end
