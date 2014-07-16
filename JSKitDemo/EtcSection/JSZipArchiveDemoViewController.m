//
//  JSZipArchiveDemoViewController.m
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

#import "JSZipArchiveDemoViewController.h"

@interface JSZipArchiveDemoViewController ()
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSString *currentPath;
@property (nonatomic, strong) NSArray *contents;

@property (nonatomic, strong) JSZipArchive *zipArchive;
@property (nonatomic, strong) dispatch_queue_t serialDispatchQueue;

@end

@implementation JSZipArchiveDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.serialDispatchQueue = dispatch_queue_create("com.js.demo", NULL);
}

- (void)reload
{
    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.currentPath error:nil];
    [self.tableView reloadData];
}

#pragma mark - IBAction
- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender
{
    NSSearchPathDirectory pathDirectory;
    switch (sender.selectedSegmentIndex) {
        case 0:
            pathDirectory = NSDocumentDirectory;
            break;

        case 1:
            pathDirectory = NSCachesDirectory;
    }

    self.currentPath = [NSSearchPathForDirectoriesInDomains(pathDirectory, NSUserDomainMask, YES) firstObject];
    [self reload];
}

- (IBAction)unzipAction:(UIButton *)sender
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"zip"];

    [self.zipArchive openWithPath:file error:nil];
    dispatch_async(self.serialDispatchQueue, ^{
        [self.zipArchive unzipToPath:self.currentPath createFolder:NO overwrite:YES error:nil];
        [self.zipArchive close];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self reload];
        });
    });
}

- (IBAction)zipAction:(UIButton *)sender
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    [self.zipArchive createZipFile:[cachesPath stringByAppendingPathComponent:@"demo.zip"] error:nil];
    dispatch_async(self.serialDispatchQueue, ^{
        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentPath error:nil];
        for (NSString *file in files) {
            [self.zipArchive zipFilePath:[documentPath stringByAppendingPathComponent:file] error:nil];
        }
        [self.zipArchive close];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self reload];
        });
    });
}

#pragma mark - JSZipArchiveDelegate
- (void)zipArchive:(JSZipArchive *)zipArchive updateProgress:(JSFloat)progress onUnzipFileName:(NSString *)unzipFileName
{
    [self.progressView setProgress:progress];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.textLabel setText:self.contents[indexPath.row]];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [self.currentPath stringByAppendingPathComponent:self.contents[indexPath.row]];
    NSDictionary *attributes = [fileManager attributesOfItemAtPath:filePath error:nil];
    if ([[attributes fileType] isEqualToString:NSFileTypeRegular]) {
        NSString *fileSizeString = [NSString stringWithFormat:@"%lld B", [attributes fileSize]];
        [cell.detailTextLabel setText:fileSizeString];
    }
    else {
        [cell.detailTextLabel setText:@""];
    }
    return cell;
}

#pragma mark - Properties
- (NSString *)currentPath
{
    if (!_currentPath) {
        _currentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    }
    return _currentPath;
}

- (NSArray *)contents
{
    if (!_contents) {
        _contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.currentPath error:nil];
    }
    return _contents;
}

- (JSZipArchive *)zipArchive
{
    if (!_zipArchive) {
        _zipArchive = [JSZipArchive new];
        [_zipArchive setDelegate:self];
    }
    return _zipArchive;
}

@end
