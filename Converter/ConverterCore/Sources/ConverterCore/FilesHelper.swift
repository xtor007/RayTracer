//
//  File.swift
//  
//
//  Created by Illia Kniaziev on 02.04.2023.
//

import Foundation

public final class FilesHelper {
    private init() {}
    
    public static func fileExists(
        filename: String,
        basePath: String = FileManager.default.currentDirectoryPath
    ) -> Bool {
        let path = basePath.appending("/").appending(filename)
        var isDirectory: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && !isDirectory.boolValue
    }
    
    public static func fileExists(atPath path: String) -> Bool {
        var isDirectory: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && !isDirectory.boolValue
    }
    
    public static func directoryExists(
        directory: String,
        basePath: String = FileManager.default.currentDirectoryPath
    ) -> Bool {
        let path = basePath.appending("/").appending(directory)
        var isDirectory: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
    
    public static func getFileUrls(
        withExtension aExtension: String,
        inDirectory directory: String,
        usingBasePath basePath: URL = URL(string: FileManager.default.currentDirectoryPath)!
    ) throws -> [URL] {
        let path = basePath.appending(path: directory)
        let fileUrls = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        return fileUrls.filter { $0.pathExtension == aExtension }
    }
    
}
