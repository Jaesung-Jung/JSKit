//
//  JSZipArchive.m
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

@import Foundation.NSString;
@import Foundation.NSFileManager;
@import Foundation.NSFileHandle;
@import Foundation.NSData;
@import Foundation.NSDate;
@import Foundation.NSError;

#import "JSZipArchive.h"
#import "NSString+CharacterCount.h"

#import "zip.h"
#import "unzip.h"

static NSString * const Domain = @"com.js.JSKit";
static const NSTimeInterval DosTimeInterval = 249001655;
static const NSUInteger BlockSize = 8192;

/*@interface JSZipContent ()

- (void)setName:(NSString *)name;
- (void)setCompressedSize:(NSUInteger)compressedSize;
- (void)setUncompressedSize:(NSUInteger)uncompressedSize;
- (void)setDate:(NSTimeInterval)date;
- (void)setCrc:(NSUInteger)crc;
- (void)setDirectory:(BOOL)directory;

@end

@implementation JSZipContent

- (void)setName:(NSString *)name { _name = name; }
- (void)setCompressedSize:(NSUInteger)compressedSize { _compressedSize = compressedSize; }
- (void)setUncompressedSize:(NSUInteger)uncompressedSize { _uncompressedSize = uncompressedSize; }
- (void)setDate:(NSTimeInterval)date { _date = date; }
- (void)setCrc:(NSUInteger)crc { _crc = crc; }
- (void)setDirectory:(BOOL)directory { _isDirectory = directory; }

@end*/

static NSArray *SupportEncodings;

@interface JSZipArchive ()

@property (nonatomic, assign) unsigned long totalSizeOfFiles;
@property (nonatomic, assign) zipFile zipFile;
@property (nonatomic, strong) NSNumber *encoding;

@property (nonatomic, strong) NSMutableArray *filesOffset;

@end

@implementation JSZipArchive

+ (void)initialize
{
    SupportEncodings = @[@(0x00000004), // Unicode (UTF-8)
                         @(0x80000940), // Korean (EUC)
                         @(0x80000422), // Korean (Windows, DOS)
                         @(0x80000A01), // Japanese (Shift JIS)
                         @(0x80000628), // Japanese (Shift JIS X0213)
                         @(0x00000008), // Japanese (Windows, DOS)
                         @(0x00000003), // Japanese (EUC)
                         @(0x80000421), // Simplified Chinese (Windows, DOS)
                         @(0x80000423), // Traditional Chinese (Windows, DOS)
                         @(0x80000930), // Simplified Chinese (EUC)
                         @(0x80000931), // Traditional Chinese (EUC)
                         @(0x80000A03), // Traditional Chinese (Big 5)
                         @(0x80000A06), // Traditional Chinese (Big 5 HKSCS)
                         @(0x00000001), // Western (ASCII)
                         @(0x80000410), // Western (DOS Latin 1)
                         @(0x0000000C), // Western (Windows Latin 1)
                         //@(0x0000001E), // Western (Mac OS Roman)
                         //@(0x800000FC), // Western (Mac VT100)
                         //@(0x00000005), // Western (ISO Latin 1)
                         //@(0x80000203), // Western (ISO Latin 3)
                         //@(0x8000020F), // Western (ISO Latin 9)
                         //@(0x80000A04), // Western (Mac Mail)
                         //@(0x00000002), // Western (NextStep)
                         //@(0x80000C02), // Western (EBCDIC US)
                         //@(0x80000840), // Korean (ISO 2022-KR)
                         //@(0x80000003), // Korean (Mac OS)
                         //@(0x00000015), // Japanese (ISO 2022-JP)
                         //@(0x80000001), // Japanese (Mac OS)
                         //@(0x80000002), // Traditional Chinese (Mac OS)
                         //@(0x80000019), // Simplified Chinese (Mac OS)
                         //@(0x80000631), // Chinese (GBK)
                         //@(0x80000632), // Chinese (GB 18030)
                         //@(0x80000004), // Arabic (Mac OS)
                         //@(0x80000005), // Hebrew (Mac OS)
                         //@(0x80000006), // Greek (Mac OS)
                         //@(0x80000007), // Cyrillic (Mac OS)
                         //@(0x80000009), // Devanagari (Mac OS)
                         //@(0x8000000A), // Gurmukhi (Mac OS)
                         //@(0x8000000B), // Gujarati (Mac OS)
                         //@(0x80000015), // Thai (Mac OS)
                         //@(0x8000001A), // Tibetan (Mac OS)
                         //@(0x8000001D), // Central European (Mac OS)
                         //@(0x00000006), // Symbol (Mac OS)
                         //@(0x80000022), // Dingbats (Mac OS)
                         //@(0x80000023), // Turkish (Mac OS)
                         //@(0x80000024), // Croatian (Mac OS)
                         //@(0x80000025), // Icelandic (Mac OS)
                         //@(0x80000026), // Romanian (Mac OS)
                         //@(0x80000029), // Keyboard Symbols (Mac OS)
                         //@(0x8000008C), // Farsi (Mac OS)
                         //@(0x80000098), // Cyrillic (Mac OS Ukrainian)
                         //@(0x0000000A), // Unicode (UTF-16)
                         //@(0x00000009), // Central European (ISO Latin 2)
                         //@(0x80000204), // Central European (ISO Latin 4)
                         //@(0x80000205), // Cyrillic (ISO 8859-5)
                         //@(0x80000206), // Arabic (ISO 8859-6)
                         //@(0x80000207), // Greek (ISO 8859-7)
                         //@(0x80000208), // Hebrew (ISO 8859-8)
                         //@(0x80000209), // Turkish (ISO Latin 5)
                         //@(0x8000020A), // Nordic (ISO Latin 6)
                         //@(0x8000020B), // Thai (ISO 8859-11)
                         //@(0x8000020D), // Baltic Rim (ISO Latin 7)
                         //@(0x8000020E), // Celtic (ISO Latin 8)
                         //@(0x80000400), // Latin-US (DOS)
                         //@(0x80000405), // Greek (DOS)
                         //@(0x80000406), // Baltic Rim (DOS)
                         //@(0x80000412), // Central European (DOS Latin 2)
                         //@(0x80000414), // Turkish (DOS)
                         //@(0x80000416), // Icelandic (DOS)
                         //@(0x80000419), // Arabic (DOS)
                         //@(0x8000041B), // Cyrillic (DOS)
                         //@(0x8000041D), // Thai (Windows, DOS)
                         //@(0x0000000F), // Central European (Windows Latin 2)
                         //@(0x0000000B), // Cyrillic (Windows)
                         //@(0x0000000D), // Greek (Windows)
                         //@(0x0000000E), // Turkish (Windows Latin 5)
                         //@(0x80000505), // Hebrew (Windows)
                         //@(0x80000506), // Arabic (Windows)
                         //@(0x80000507), // Baltic Rim (Windows)
                         //@(0x80000508), // Vietnamese (Windows)
                         //@(0x80000A02), // Cyrillic (KOI8-R)
                         //@(0x00000007), // Non-lossy ASCII
                         ];
}

- (void)dealloc
{
    [self close];
}

- (void)openWithPath:(NSString *)path password:(NSString *)password error:(NSError *__autoreleasing *)error
{
    self.password = password;
    [self openWithPath:path error:error];
}

- (void)openWithPath:(NSString *)path error:(NSError *__autoreleasing *)error
{
    [self close];

    NSInteger resultCode;
    self.zipFile = unzOpen((const char *)[path UTF8String]);
    if (self.zipFile == NULL) {
        [JSZipArchive setError:error code:JSZipArchiveErrorFileOpen path:path];
        return;
    }

    unz_global_info globalInfo;
    resultCode = unzGetGlobalInfo(self.zipFile, &globalInfo);
    if (resultCode == UNZ_OK) {
        char *commentBuffer = (char *)malloc(globalInfo.size_comment + 1);
        unzGetGlobalComment(self.zipFile, commentBuffer, globalInfo.size_comment);
        _comment = [NSString stringWithCString:commentBuffer encoding:NSASCIIStringEncoding];
        free(commentBuffer);
    }

    // Check encrypted and calculate total size of files
    BOOL checkedEncrypt = NO;
    char checkBlock[1] = { 0x00 };
    resultCode = unzGoToFirstFile(self.zipFile);
    if (resultCode == UNZ_OK) {
        do {
            resultCode = unzOpenCurrentFile(self.zipFile);
            if (resultCode != UNZ_OK) break;

            // Check encrypted
            if (!checkedEncrypt && unzReadCurrentFile(self.zipFile, checkBlock, sizeof(checkBlock)) < 0) {
                _encrypted = YES;
            }
            checkedEncrypt = YES;
            
            // Calculate total size of files and counting files
            unz_file_info fileInfo;
            char contentFileNameBuffer[256] = { 0x00, };
            resultCode = unzGetCurrentFileInfo(self.zipFile, &fileInfo, contentFileNameBuffer, sizeof(contentFileNameBuffer), NULL, 0, NULL, 0);
            if (resultCode != UNZ_OK) break;

            self.totalSizeOfFiles += fileInfo.uncompressed_size;

            NSString *contentName;
            if (self.encoding) {
                contentName = [NSString stringWithCString:contentFileNameBuffer encoding:[self.encoding unsignedIntegerValue]];
            }
            else {
                for (NSNumber *supportEncoding in SupportEncodings) {
                    NSString *decodeString = [NSString stringWithCString:contentFileNameBuffer encoding:[supportEncoding unsignedIntegerValue]];
                    if (decodeString) {
                        contentName = decodeString;
                        self.encoding = supportEncoding;
                        break;
                    }
                }
            }
            BOOL isDirectory = [contentName characterAtIndex:[contentName length] - 1] == '/' ? YES : NO;
            if (!isDirectory) {
                _fileCount++;
                uLong offset = unzGetOffset(self.zipFile);
                [self.filesOffset addObject:@(offset)];
            }
        } while (unzGoToNextFile(self.zipFile) != UNZ_END_OF_LIST_OF_FILE);
    }

    if (resultCode == UNZ_OK) {
        NSUInteger startLocation = [path rangeOfString:@"/" options:NSBackwardsSearch].location + 1;
        NSUInteger endLocation = [path rangeOfString:@"." options:NSBackwardsSearch].location;
        _zipFileName = [path substringWithRange:NSMakeRange(startLocation, endLocation - startLocation)];
        _zipFilePath = path;
        
        unzGoToFirstFile(self.zipFile);
    }
    else {
        [JSZipArchive setError:error code:resultCode path:path];
        [self close];
    }
}

- (void)close
{
    if (_zipFile) {
        unzClose(_zipFile);
        _zipFile = nil;
        _encoding = nil;
        _zipFilePath = nil;
        _zipFileName = nil;
        _password = nil;
        _comment = nil;
        _encrypted = NO;
        _totalSizeOfFiles = 0;
    }
}

- (void)unzipToPath:(NSString *)path error:(NSError *__autoreleasing *)error
{
    [self unzipToPath:path createFolder:YES overwrite:YES error:error];
}

- (void)unzipToPath:(NSString *)path createFolder:(BOOL)createFolder error:(NSError *__autoreleasing *)error
{
    [self unzipToPath:path createFolder:createFolder overwrite:YES error:error];
}

- (void)unzipToPath:(NSString *)path overwrite:(BOOL)overwrite error:(NSError *__autoreleasing *)error
{
    [self unzipToPath:path createFolder:YES overwrite:overwrite error:error];
}

- (void)unzipToPath:(NSString *)path createFolder:(BOOL)createFolder overwrite:(BOOL)overwrite error:(NSError *__autoreleasing *)error
{
    if (!self.isOpened) {
        [JSZipArchive setError:error code:JSZipArchiveErrorFileIsNotOpened path:nil];
        return;
    }
    if (self.password == nil && self.encrypted) {
        [JSZipArchive setError:error code:JSZipArchiveErrorBadPassword path:nil];
        return;
    }

    NSInteger resultCode;

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (createFolder) {
        path = [path stringByAppendingPathComponent:self.zipFileName];
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(zipArchive:willBeginUnzipOnZipFileName:)]) {
        [self.delegate zipArchive:self willBeginUnzipOnZipFileName:self.zipFileName];
    }

    unsigned long unzippedSize = 0;
    unzGoToFirstFile(self.zipFile);
    do {
        if (self.password) {
            resultCode = unzOpenCurrentFilePassword(self.zipFile, [self.password UTF8String]);
        }
        else {
            resultCode = unzOpenCurrentFile(self.zipFile);
        }
        if (resultCode != UNZ_OK) {
            [JSZipArchive setError:error code:resultCode path:self.zipFilePath];
            break;
        }
        
        // Read file info
        unz_file_info fileInfo;
        char contentFileNameBuffer[256] = { 0x00, };
        unzGetCurrentFileInfo(self.zipFile, &fileInfo, contentFileNameBuffer, sizeof(contentFileNameBuffer) - 1, NULL, 0, NULL, 0);
        
        // Convert file name
        NSString *contentName = [NSString stringWithCString:contentFileNameBuffer encoding:[self.encoding unsignedIntegerValue]];
        
        // Create folder and extract file
        BOOL isDirectory = [contentName characterAtIndex:[contentName length] - 1] == '/' ? YES : NO;
        NSString *fullPath = [path stringByAppendingPathComponent:contentName];
        if (isDirectory) {
            [fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        else {
            if (![fileManager fileExistsAtPath:fullPath] || overwrite) {
                if (![fileManager fileExistsAtPath:fullPath]) {
                    [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
                }

                NSInteger readByte = 0;
                Byte blockBuffer[BlockSize] = { 0x00, };
                NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:fullPath];
                do {
                    readByte = unzReadCurrentFile(self.zipFile, blockBuffer, sizeof(blockBuffer));
                    NSData *block = [NSData dataWithBytes:blockBuffer length:readByte];
                    [fileHandle writeData:block];
                    unzippedSize += readByte;
                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(zipArchive:updateProgress:onUnzipFileName:)]) {
                        [self.delegate zipArchive:self updateProgress:(double)unzippedSize / (double)self.totalSizeOfFiles onUnzipFileName:contentName];
                    }
                } while (readByte > 0);

                [fileHandle closeFile];
            }
            else {
                unzippedSize += fileInfo.uncompressed_size;
                [self.delegate zipArchive:self updateProgress:(double)unzippedSize / (double)self.totalSizeOfFiles onUnzipFileName:contentName];
            }
        }
        // Set file modification date
        NSDate *fileDate = [NSDate dateWithTimeIntervalSince1970:fileInfo.dosDate + DosTimeInterval];
        NSDictionary *fileAttributes = @{NSFileModificationDate: fileDate};
        [fileManager setAttributes:fileAttributes ofItemAtPath:fullPath error:nil];
        
        unzCloseCurrentFile(self.zipFile);
    } while (unzGoToNextFile(self.zipFile) != UNZ_END_OF_LIST_OF_FILE);

    if (self.delegate && [self.delegate respondsToSelector:@selector(zipArchive:didEndUnzipOnZipFileName:)]) {
        [self.delegate zipArchive:self didEndUnzipOnZipFileName:self.zipFileName];
    }
}

- (NSArray *)unzipToArray
{
    if (!self.isOpened || (self.password == nil && self.encrypted)) {
        return nil;
    }

    if (self.delegate) {
        [self.delegate zipArchive:self willBeginUnzipOnZipFileName:self.zipFileName];
    }

    NSMutableArray *unzippedDatas = [NSMutableArray array];
    unsigned long unzippedSize = 0;

    if (self.delegate && [self.delegate respondsToSelector:@selector(zipArchive:willBeginUnzipOnZipFileName:)]) {
        [self.delegate zipArchive:self willBeginUnzipOnZipFileName:self.zipFileName];
    }
    unzGoToFirstFile(self.zipFile);
    do {
        if (self.password) {
            unzOpenCurrentFilePassword(self.zipFile, [self.password UTF8String]);
        }
        else {
            unzOpenCurrentFile(self.zipFile);
        }

        // Read file info
        unz_file_info fileInfo;
        char contentFileNameBuffer[256] = { 0x00, };
        unzGetCurrentFileInfo(self.zipFile, &fileInfo, contentFileNameBuffer, sizeof(contentFileNameBuffer) - 1, NULL, 0, NULL, 0);

        // Convert file name
        NSString *contentName = [NSString stringWithCString:contentFileNameBuffer encoding:[self.encoding unsignedIntegerValue]];

        JSUnzippedData *unzippedData = [JSUnzippedData new];
        unzippedData.name = contentName;
        unzippedData.modificationDate = [NSDate dateWithTimeIntervalSince1970:fileInfo.dosDate + DosTimeInterval];
        unzippedData.offset = unzGetOffset(self.zipFile);

        BOOL isDirectory = [contentName characterAtIndex:[contentName length] - 1] == '/' ? YES : NO;
        if (isDirectory) {
            unzippedData.isDirectory = YES;
            unzippedData.childFiles = [NSMutableArray array];
        }
        else {
            NSInteger readByte = 0;
            Byte block[BlockSize] = { 0x00, };
            NSMutableData *data = [NSMutableData data];
            do {
                readByte = unzReadCurrentFile(self.zipFile, block, sizeof(block));
                [data appendBytes:block length:readByte];
                unzippedSize += readByte;
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(zipArchive:updateProgress:onUnzipFileName:)]) {
                    [self.delegate zipArchive:self updateProgress:(double)unzippedSize / (double)self.totalSizeOfFiles onUnzipFileName:contentName];
                }
            } while (readByte > 0);

            unzippedData.data = data;
        }
        unzCloseCurrentFile(self.zipFile);

        // find data position
        NSMutableString *folderName = [NSMutableString stringWithString:[contentName stringByDeletingLastPathComponent]];
        [folderName appendString:@"/"];
        [self appendUnzippedData:unzippedData intoFolderName:folderName inArray:unzippedDatas];
    } while (unzGoToNextFile(self.zipFile) != UNZ_END_OF_LIST_OF_FILE);

    if (self.delegate && [self.delegate respondsToSelector:@selector(zipArchive:didEndUnzipOnZipFileName:)]) {
        [self.delegate zipArchive:self didEndUnzipOnZipFileName:self.zipFileName];
    }

    return [self arrayBySortedUnzippedDatas:unzippedDatas];
}

- (JSUnzippedData *)unzipFirstFile
{
    if (!self.isOpened || (self.password == nil && self.encrypted)) {
        return nil;
    }

    NSMutableArray *fileList = [NSMutableArray array];

    unzGoToFirstFile(self.zipFile);
    do {
        if (self.password) {
            unzOpenCurrentFilePassword(self.zipFile, [self.password UTF8String]);
        }
        else {
            unzOpenCurrentFile(self.zipFile);
        }
        
        // Read file info
        unz_file_info fileInfo;
        char contentFileNameBuffer[256] = { 0x00, };
        unzGetCurrentFileInfo(self.zipFile, &fileInfo, contentFileNameBuffer, sizeof(contentFileNameBuffer) - 1, NULL, 0, NULL, 0);
        
        // Convert file name
        NSString *contentName = [NSString stringWithCString:contentFileNameBuffer encoding:[self.encoding unsignedIntegerValue]];
        
        BOOL isDirectory = [contentName characterAtIndex:[contentName length] - 1] == '/' ? YES : NO;
        if (!isDirectory) {
            [fileList addObject:contentName];
        }
        unzCloseCurrentFile(self.zipFile);
    } while (unzGoToNextFile(self.zipFile) != UNZ_END_OF_LIST_OF_FILE);

    NSString *firstFileName = [[fileList sortedArrayUsingComparator:^NSComparisonResult(NSString *item1, NSString *item2) {
        NSUInteger countOfSlashInItem1 = [item1 occurrencesOfCharacter:'/'];
        NSUInteger countOfSlashInItem2 = [item2 occurrencesOfCharacter:'/'];
        if (countOfSlashInItem1 == countOfSlashInItem2) {
            return  [item1 compare:item2];
        }
        else if (countOfSlashInItem1 > countOfSlashInItem2) {
            return NSOrderedDescending;
        }
        else {
            return NSOrderedAscending;
        }
    }] firstObject];

    JSUnzippedData *unzippedData = nil;
    unzGoToFirstFile(self.zipFile);
    do {
        if (self.password) {
            unzOpenCurrentFilePassword(self.zipFile, [self.password UTF8String]);
        }
        else {
            unzOpenCurrentFile(self.zipFile);

            // Read file info
            unz_file_info fileInfo;
            char contentFileNameBuffer[256] = { 0x00, };
            unzGetCurrentFileInfo(self.zipFile, &fileInfo, contentFileNameBuffer, sizeof(contentFileNameBuffer) - 1, NULL, 0, NULL, 0);
            
            // Read file name and find string encoding
            NSString *contentName = [NSString stringWithCString:contentFileNameBuffer encoding:[self.encoding unsignedIntegerValue]];
            if ([contentName isEqualToString:firstFileName]) {
                unzippedData = [JSUnzippedData new];
                unzippedData.name = contentName;
                unzippedData.modificationDate = [NSDate dateWithTimeIntervalSince1970:fileInfo.dosDate + DosTimeInterval];
                unzippedData.offset = unzGetOffset(self.zipFile);

                NSInteger readByte = 0;
                Byte block[BlockSize] = { 0x00, };
                NSMutableData *data = [NSMutableData data];
                do {
                    readByte = unzReadCurrentFile(self.zipFile, block, sizeof(block));
                    [data appendBytes:block length:readByte];
                } while (readByte > 0);

                unzippedData.data = data;
            }
            unzCloseCurrentFile(self.zipFile);
        }
    } while (unzGoToNextFile(self.zipFile) != UNZ_END_OF_LIST_OF_FILE && unzippedData == nil);

    return unzippedData;
}

- (JSUnzippedData *)unzipFileAtIndex:(NSUInteger)index
{
    if (!self.isOpened || (self.password == nil && self.encrypted) || self.fileCount <= index) {
        return nil;
    }

    JSUnzippedData *unzippedData = nil;
    uLong offset = [self.filesOffset[index] unsignedLongValue];

    unzSetOffset(self.zipFile, offset);
    if (self.password) {
        unzOpenCurrentFilePassword(self.zipFile, [self.password UTF8String]);
    }
    else {
        unzOpenCurrentFile(self.zipFile);
    }

    unz_file_info fileInfo;
    char contentFileNameBuffer[256] = { 0x00, };
    unzGetCurrentFileInfo(self.zipFile, &fileInfo, contentFileNameBuffer, sizeof(contentFileNameBuffer) - 1, NULL, 0, NULL, 0);
    
    NSString *contentName = [NSString stringWithCString:contentFileNameBuffer encoding:[self.encoding unsignedIntegerValue]];
    NSInteger readByte = 0;
    Byte block[BlockSize] = { 0x00, };
    NSMutableData *data = [NSMutableData data];
    do {
        readByte = unzReadCurrentFile(self.zipFile, block, sizeof(block));
        [data appendBytes:block length:readByte];
    } while (readByte > 0);
    
    unzippedData = [JSUnzippedData new];
    unzippedData.name = contentName;
    unzippedData.modificationDate = [NSDate dateWithTimeIntervalSince1970:fileInfo.dosDate + DosTimeInterval];
    unzippedData.data = data;
    unzippedData.offset = offset;
    unzCloseCurrentFile(self.zipFile);
    return unzippedData;
}

- (NSUInteger)indexOfFileOffset:(NSUInteger)offset
{
    return [self.filesOffset indexOfObject:@(offset)];
}

- (NSUInteger)offsetAtIndex:(NSUInteger)index
{
    return [self.filesOffset[index] unsignedIntegerValue];
}

- (void)appendUnzippedData:(JSUnzippedData *)data intoFolderName:(NSString *)folderName inArray:(NSMutableArray *)array
{
    if ([folderName isEqualToString:@"/"]) {
        //[array addObject:data];
        [array insertObject:data atIndex:[array count]];
    }
    else {
        for (JSUnzippedData *item in array) {
            if ([folderName isEqualToString:item.name]) {
                [(NSMutableArray *)item.childFiles insertObject:data atIndex:[item.childFiles count]];
                //[(NSMutableArray *)item.childFiles addObject:data];
            }
            else {
                [self appendUnzippedData:data intoFolderName:folderName inArray:(NSMutableArray *)item.childFiles];
            }
        }
    }
}

- (NSArray *)arrayBySortedUnzippedDatas:(NSArray *)unzippedDatas
{
    unzippedDatas = [unzippedDatas sortedArrayUsingComparator:^NSComparisonResult(JSUnzippedData *item1, JSUnzippedData *item2) {
        if (item1.isDirectory == item2.isDirectory) {
            return [item1.name compare:item2.name];
        }
        else if (item1.isDirectory) {
            return NSOrderedDescending;
        }
        else {
            return NSOrderedAscending;
        }
    }];

    for (JSUnzippedData *data in unzippedDatas) {
        if (data.childFiles) {
            data.childFiles = [self arrayBySortedUnzippedDatas:data.childFiles];
        }
    }

    return unzippedDatas;
}

+ (void)setError:(NSError *__autoreleasing *)error code:(NSInteger)code path:(NSString *)path
{
    if (error) {
        NSString *description;
        JSZipArchiveError errorCode;
        switch (code) {
            case JSZipArchiveErrorFileOpen:
                errorCode = code;
                description = [NSString stringWithFormat:@"Failed file open. (%@)", path];
                break;
            
            case JSZipArchiveErrorFileIsNotOpened:
                errorCode = code;
                description = @"File is not opened.";
                break;

            case UNZ_BADZIPFILE:
                errorCode = JSZipArchiveErrorBadZipFile;
                description = [NSString stringWithFormat:@"Bad zip file. (%@)", path];
                break;

            case UNZ_CRCERROR:
                errorCode = JSZipArchiveErrorCRC;
                description = [NSString stringWithFormat:@"CRC error. (%@)", path];
                break;

            case UNZ_PARAMERROR:
                errorCode = JSZipArchiveErrorBadParameter;
                description = [NSString stringWithFormat:@"Bad parameter. (%@)", path];
                break;

            case JSZipArchiveErrorBadPassword:
                errorCode = code;
                description = [NSString stringWithFormat:@"Bad password. (%@)", path];
                break;

            case UNZ_INTERNALERROR:
                errorCode = JSZipArchiveErrorInternalError;
                description = [NSString stringWithFormat:@"Internal error. (%@)", path];
                break;
                
            default:
                errorCode = JSZipArchiveErrorUnknown;
                description = [NSString stringWithFormat:@"Unknown error. (%@)", path];
                break;
        }
        *error = [NSError errorWithDomain:Domain code:errorCode userInfo:@{NSLocalizedDescriptionKey: description}];
    }
}

- (BOOL)isOpened
{
    return self.zipFile != NULL;
}

- (NSMutableArray *)filesOffset
{
    if (!_filesOffset) {
        _filesOffset = [NSMutableArray array];
    }
    return _filesOffset;
}

@end

@implementation JSUnzippedData

@end
