//
//  JSViewController.m
//
//  Copyright (c) 2014 Jaesung Jung
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "JSViewController.h"

#pragma mark - JSTestItem
@interface JSTestItem : NSObject

@property (nonatomic, strong) NSString *testName;
@property (nonatomic, strong) NSString *segueIdentifier;

+ (instancetype)itemWithTestName:(NSString *)testName segueIdentifier:(NSString *)segueIdentifier;

@end

@implementation JSTestItem

+ (instancetype)itemWithTestName:(NSString *)testName segueIdentifier:(NSString *)segueIdentifier {
    JSTestItem *testItem = [[JSTestItem alloc] init];
    testItem.testName = testName;
    testItem.segueIdentifier = segueIdentifier;
    return testItem;
}

@end

#pragma mark - JSViewController
@interface JSViewController ()

@property (nonatomic, strong) NSDictionary *testItemTable;
@property (nonatomic, strong) NSArray      *testItemSections;

@end

@implementation JSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.testItemTable = @{@"Animation" : @[[JSTestItem itemWithTestName:@"Animation Step"      segueIdentifier:@"AnimationStepSegue"]],
                           @"Image"     : @[[JSTestItem itemWithTestName:@"Blur Effect Image"   segueIdentifier:@"BlurEffectImageSegue"],
                                            [JSTestItem itemWithTestName:@"Circular Image View" segueIdentifier:@"CircularImageViewSegue"]]};

    self.testItemSections = [self.testItemTable allKeys];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *sectionKey = self.testItemSections[indexPath.section];
    NSString *segueIdentifier = ((JSTestItem *)self.testItemTable[sectionKey][indexPath.row]).segueIdentifier;

    [self performSegueWithIdentifier:segueIdentifier sender:self];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.testItemSections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.testItemSections[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionKey = self.testItemSections[section];
    return [self.testItemTable[sectionKey] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *sectionKey = self.testItemSections[indexPath.section];
    JSTestItem *testItem = self.testItemTable[sectionKey][indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemoCell" forIndexPath:indexPath];
    [cell.textLabel setText:testItem.testName];
    return cell;
}

@end
