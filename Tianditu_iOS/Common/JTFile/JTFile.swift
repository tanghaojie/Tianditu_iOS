//
//  File.swift
//
//  Created by JT on 2018/4/11.
//  Copyright © 2018年 JT. All rights reserved.
//
import Foundation
class JTFile {
    static let shareInstance = JTFile()
    private init() {}
    private let fileManager = FileManager.default
    
    lazy var documentString: String? = {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }()
    lazy var documentURL: URL? = {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).last
    }()
    lazy var cacheString: String? = {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }()
    lazy var tmpDir: String = {
        var x = NSTemporaryDirectory()
        if "/" == x.last {
            x.removeLast()
        }
        return x
    }()
    
    func saveFile(url: URL, data: Data) -> Bool {
        let dir = url.deletingLastPathComponent()
        guard createDirectory(url: dir) else { return false }
        do {
            try data.write(to: url)
            return true
        }
        catch { return false }
    }
    func createDirectory(path: String) -> Bool {
        var isDir = ObjCBool(true)
        if fileManager.fileExists(atPath: path, isDirectory: &isDir) { return true }
        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            return true
        }
        catch { return false }
    }
    func createDirectory(url: URL) -> Bool {
        var isDir = ObjCBool(true)
        if fileManager.fileExists(atPath: url.path, isDirectory: &isDir) { return true }
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            return true
        }
        catch { return false }
    }
    func copyItem(from: URL, to: URL) -> Bool {
        guard fileManager.fileExists(atPath: from.path) && fileManager.isReadableFile(atPath: from.path) else { return false }
        do {
            try fileManager.copyItem(at: from, to: to)
            return true
        }
        catch { return false }
    }
    func directoryExist(atPath: URL) -> Bool {
        var isDir = ObjCBool(true)
        return fileManager.fileExists(atPath: atPath.path, isDirectory: &isDir)
    }
    func directoryExist(atPath: String) -> Bool {
        var isDir = ObjCBool(true)
        return fileManager.fileExists(atPath: atPath, isDirectory: &isDir)
    }
    func fileExist(atPath: URL) -> Bool {
        return fileManager.fileExists(atPath: atPath.path)
    }
    func fileExist(atPath: String) -> Bool {
        return fileManager.fileExists(atPath: atPath)
    }
    func deleteFile(url: URL) -> Bool {
        if !fileExist(atPath: url) { return true }
        if !fileManager.isDeletableFile(atPath: url.path) { return false }
        do {
            try fileManager.removeItem(at: url)
            return true
        }
        catch { return false }
    }
    
}
