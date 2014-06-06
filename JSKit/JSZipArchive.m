//
//  JSZipArchive.m
//  JSKit
//
//  Created by 정재성 on 2014. 6. 4..
//  Copyright (c) 2014년 Jaesung Jung. All rights reserved.
//

@import Foundation;

#import "JSZipArchive.h"

#import "zip.h"
#import "unzip.h"

static NSString * const Domain = @"com.js.JSKit";
static const NSTimeInterval DosTimeInterval = 249001655;

@interface JSZipContent ()

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
- (void)setUnzipData:(NSData *)unzipData { _unzipData = unzipData; }

@end

static NSArray *SupportEncodings;

@interface JSZipArchive ()

@property (nonatomic, readonly) NSDate * date1980;

@end

@implementation JSZipArchive

@synthesize date1980 = _date1980;

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

- (void)openWithPath:(NSString *)path password:(NSString *)password error:(NSError *__autoreleasing *)error
{
    self.password = password;
    [self openWithPath:path error:error];
}

- (void)openWithPath:(NSString *)path error:(NSError *__autoreleasing *)error
{
    [self reset];

    NSInteger resultCode;
    unzFile unzFile = unzOpen((const char *)[path UTF8String]);
    if (unzFile == NULL) {
        [JSZipArchive setError:error code:JSZipArchiveErrorFileOpen path:path];
        return;
    }

    unz_global_info globalInfo;
    resultCode = unzGetGlobalInfo(unzFile, &globalInfo);
    if (resultCode == UNZ_OK) {
        char *commentBuffer = (char *)malloc(globalInfo.size_comment + 1);
        unzGetGlobalComment(unzFile, commentBuffer, globalInfo.size_comment);
        self.comment = [NSString stringWithCString:commentBuffer encoding:NSASCIIStringEncoding];
        free(commentBuffer);
    }

    resultCode = unzGoToFirstFile(unzFile);
    if (resultCode == UNZ_OK) {
        NSMutableArray *contents = [NSMutableArray array];
        NSNumber *encoding;
        do {
            resultCode = unzOpenCurrentFile(unzFile);
            if (resultCode != UNZ_OK) {
                [JSZipArchive setError:error code:resultCode path:path];
                break;
            }

            unz_file_info fileInfo;
            char contentFileNameBuffer[256] = {0x00,};
            resultCode = unzGetCurrentFileInfo(unzFile, &fileInfo, contentFileNameBuffer, sizeof(contentFileNameBuffer), NULL, 0, NULL, 0);
            if (resultCode != UNZ_OK) {
                [JSZipArchive setError:error code:resultCode path:path];
                break;
            }

            NSString *contentName;
            if (encoding) {
                contentName = [NSString stringWithCString:contentFileNameBuffer encoding:[encoding unsignedIntegerValue]];
            }
            else {
                for (NSUInteger i = 0; encoding == nil && i < [SupportEncodings count]; i++) {
                    NSString *decodeString = [NSString stringWithCString:contentFileNameBuffer encoding:[SupportEncodings[i] unsignedIntegerValue]];
                    if (decodeString != nil) {
                        contentName = decodeString;
                        encoding = SupportEncodings[i];
                    }
                }
            }
            unzCloseCurrentFile(unzFile);

            JSZipContent *content = [JSZipContent new];
            [content setName:contentName];
            [content setCompressedSize:fileInfo.compressed_size];
            [content setUncompressedSize:fileInfo.uncompressed_size];
            [content setDate:fileInfo.dosDate + DosTimeInterval];
            [content setDirectory:[contentName characterAtIndex:[contentName length] - 1] == '/'];
            [contents addObject:content];
        } while (unzGoToNextFile(unzFile) != UNZ_END_OF_LIST_OF_FILE);
        _contents = contents;
    }
    else {
        [JSZipArchive setError:error code:resultCode path:path];
    }
    unzClose(unzFile);

    if (resultCode == UNZ_OK) {
        _isOpened = YES;

        self.zipFilePath = path;
        NSUInteger startLocation = [path rangeOfString:@"/" options:NSBackwardsSearch].location + 1;
        NSUInteger endLocation = [path rangeOfString:@"." options:NSBackwardsSearch].location;
        self.zipFileName = [path substringWithRange:NSMakeRange(startLocation, endLocation - startLocation)];
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
    if (!_isOpened) {
        return;
    }

    NSInteger resultCode;
    unzFile unzFile = unzOpen([self.zipFilePath UTF8String]);
    if (unzFile == NULL) {
        [JSZipArchive setError:error code:JSZipArchiveErrorFileOpen path:path];
        return;
    }

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (createFolder) {
        path = [path stringByAppendingPathComponent:self.zipFileName];
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }

    resultCode = unzGoToFirstFile(unzFile);
    if (resultCode == UNZ_OK) {
        for (JSZipContent *content in self.contents) {
            resultCode = unzOpenCurrentFile(unzFile);
            if (resultCode != UNZ_OK) {
                [JSZipArchive setError:error code:resultCode path:path];
                break;
            }

            NSString *fullPath = [path stringByAppendingPathComponent:content.name];
            if (content.isDirectory) {
                [fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            else {
                if (![fileManager fileExistsAtPath:fullPath] || overwrite) {
                    NSInteger readByte = 0;
                    Byte buffer[4096] = {0x00,};
                    NSMutableData *data = [NSMutableData data];
                    do {
                        readByte = unzReadCurrentFile(unzFile, buffer, sizeof(buffer));
                        [data appendBytes:buffer length:readByte];
                    } while (readByte > 0);

                    [data writeToFile:fullPath atomically:YES];
                    NSDate *fileDate = [NSDate dateWithTimeIntervalSince1970:content.date];
                    NSDictionary *fileAttributes = @{NSFileModificationDate: fileDate};
                    [fileManager setAttributes:fileAttributes ofItemAtPath:fullPath error:nil];
                }
            }

            unzCloseCurrentFile(unzFile);
            resultCode = unzGoToNextFile(unzFile);
            if (resultCode != UNZ_OK) {
                [JSZipArchive setError:error code:resultCode path:path];
                break;
            }
        }
    }
    else {
        [JSZipArchive setError:error code:resultCode path:path];
    }
    unzClose(unzFile);
}

- (NSArray *)arrayByUnzip
{
    if (!_isOpened) {
        return nil;
    }

    unzFile unzFile = unzOpen([self.zipFilePath UTF8String]);
    if (unzFile == NULL) {
        return nil;
    }

    NSMutableArray *unzipContents = [NSMutableArray arrayWithArray:self.contents];
    unzGoToFirstFile(unzFile);
    for (JSZipContent *content in unzipContents) {
        unzOpenCurrentFile(unzFile);

        if (!content.isDirectory) {
            NSInteger readByte = 0;
            Byte buffer[4096] = {0x00,};
            NSMutableData *data = [NSMutableData data];
            do {
                readByte = unzReadCurrentFile(unzFile, buffer, sizeof(buffer));
                [data appendBytes:buffer length:readByte];
            } while (readByte > 0);
            [content setUnzipData:data];
        }

        unzCloseCurrentFile(unzFile);
        unzGoToNextFile(unzFile);
    }
    unzClose(unzFile);

    return unzipContents;
}

- (NSArray *)arrayByUnzipAtIndexSet:(NSIndexSet *)indexSet
{
    if (!_isOpened) {
        return nil;
    }
    
    unzFile unzFile = unzOpen([self.zipFilePath UTF8String]);
    if (unzFile == NULL) {
        return nil;
    }

    NSUInteger fileContentIndex = 0; // Without directory
    NSMutableArray *unzipContents = [NSMutableArray array];
    unzGoToFirstFile(unzFile);
    for (JSZipContent *content in self.contents) {
        unzOpenCurrentFile(unzFile);

        if (!content.isDirectory) {
            if ([indexSet containsIndex:fileContentIndex]) {
                NSInteger readByte = 0;
                Byte buffer[4096] = {0x00,};
                NSMutableData *data = [NSMutableData data];

                do {
                    readByte = unzReadCurrentFile(unzFile, buffer, sizeof(buffer));
                    [data appendBytes:buffer length:readByte];
                } while (readByte > 0);
                [content setUnzipData:data];
                unzCloseCurrentFile(unzFile);

                JSZipContent *newContent = [JSZipContent new];
                [newContent setName:content.name];
                [newContent setCompressedSize:content.compressedSize];
                [newContent setUncompressedSize:content.uncompressedSize];
                [newContent setDate:content.date];
                [newContent setCrc:content.crc];
                [newContent setDirectory:content.isDirectory];
                [newContent setUnzipData:data];

                [unzipContents addObject:newContent];
            }
            fileContentIndex++;
        }
        unzGoToNextFile(unzFile);
    }
    unzClose(unzFile);
    return unzipContents;
}

- (void)reset
{
    _zipFilePath = nil;
    _zipFileName = nil;
    _password = nil;
    _comment = nil;
    _contents = nil;
    _isOpened = NO;
}

+ (void)setError:(NSError *__autoreleasing *)error code:(NSInteger)code path:(NSString *)path
{
    if (error != nil) {
        NSString *description;
        JSZipArchiveError errorCode;
        switch (code) {
            case JSZipArchiveErrorFileOpen:
                errorCode = code;
                description = [NSString stringWithFormat:@"Failed file open. (%@)", path];
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

@end
