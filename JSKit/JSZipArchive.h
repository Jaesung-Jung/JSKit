//
//  JSZipArchive.h
//  JSKit
//
//  Created by 정재성 on 2014. 6. 4..
//  Copyright (c) 2014년 Jaesung Jung. All rights reserved.
//

@import Foundation.NSObject;

typedef NS_ENUM(NSInteger, JSZipArchiveError) {
    JSZipArchiveErrorFileOpen = 1,
    JSZipArchiveErrorBadZipFile,
    JSZipArchiveErrorBadParameter,
    JSZipArchiveErrorInternalError,
    JSZipArchiveErrorCRC,
    JSZipArchiveErrorUnknown,
};

@class JSZipContent;

NS_CLASS_AVAILABLE_IOS(2_0) @interface JSZipArchive : NSObject

@property (nonatomic, strong) NSString *zipFilePath;
@property (nonatomic, strong) NSString *zipFileName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *comment;

@property (nonatomic, readonly) NSArray *contents;

@property (nonatomic, readonly) BOOL isOpened;

/*!
 * Open an existing zip file ready for unzip.
 *
 * @params path Path of zip file.
 * @params error On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information.
 */
- (void)openWithPath:(NSString *)path error:(NSError **)error;

/*!
 * Open an existing zip file ready for unzip.
 *
 * @params path Path of the zip file.
 * @params password Password of the zip file.
 * @params error On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information.
 */
- (void)openWithPath:(NSString *)path password:(NSString *)password error:(NSError **)error;

/*!
 * Unzip all files in the zip archive into the specified path.
 *
 * @params path Path of unzip.
 * @params error On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information.
 */
- (void)unzipToPath:(NSString *)path error:(NSError **)error;

/*!
 * Unzip all files in the zip archive into the specified path.
 *
 * @params path Path of unzip.
 * @params overwirte If yes, existing files be overwite.
 * @params error On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information.
 */
- (void)unzipToPath:(NSString *)path overwrite:(BOOL)overwrite error:(NSError **)error;

/*!
 * Unzip all files in the zip archive into the specified path.
 *
 * @params path Path of unzip.
 * @params createFolder If yes, create root folder for unzip.
 * @params error On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information.
 */
- (void)unzipToPath:(NSString *)path createFolder:(BOOL)createFolder error:(NSError **)error;

/*!
 * Unzip all files in the zip archive into the specified path.
 *
 * @params path Path of unzip.
 * @params createFolder If yes, create root folder for unzip.
 * @params overwirte If yes, existing files be overwite.
 * @params error On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information.
 */
- (void)unzipToPath:(NSString *)path createFolder:(BOOL)createFolder overwrite:(BOOL)overwrite error:(NSError **)error;

/*!
 * Unzip all files in the zip archive into the memory.
 *
 * @return JSZipContent array that contains unzip data.
 */
- (NSArray *)arrayByUnzip;

/*!
 * Unzip given indexes file in the zip archive into the memory.
 *
 * @params indexSet index set for zip content.
 *
 * @return JSZipContent array that contains unzip data.
 */
- (NSArray *)arrayByUnzipAtIndexSet:(NSIndexSet *)indexSet;

@end

@interface JSZipContent : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSUInteger compressedSize;
@property (nonatomic, readonly) NSUInteger uncompressedSize;
@property (nonatomic, readonly) NSTimeInterval date;
@property (nonatomic, readonly) NSUInteger crc;
@property (nonatomic, readonly) BOOL isDirectory;

@property (nonatomic, readonly) NSData *unzipData;

@end
