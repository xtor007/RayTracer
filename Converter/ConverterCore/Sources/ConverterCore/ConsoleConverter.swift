//
//  File.swift
//  
//
//  Created by Illia Kniaziev on 02.04.2023.
//

import ArgumentParser
import Foundation

struct ConsoleConverter: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        commandName: "converter",
        abstract: "Converts an image file to a different format.",
        version: "1.0.0",
        shouldDisplay: true,
        subcommands: [],
        defaultSubcommand: nil,
        helpNames: [.short, .long, .customLong("hlp")]
    )
    
    @Option(name: .shortAndLong, help: "The source image file.")
    var source: String
    
    @Option(name: .shortAndLong, help: "The format to convert the image to.")
    var goalFormat: String
    
    func run() throws {
        let sourceURL = URL(fileURLWithPath: "\(FileManager.default.currentDirectoryPath)/\(source)")
        let goalURL = sourceURL.deletingPathExtension().appendingPathExtension(goalFormat)

        guard FilesHelper.fileExists(filename: source) else {
            print("Error: source file does not exist")
            return
        }
        
        let data = try Data(contentsOf: sourceURL)
        guard let reader = try LibsFactory.getReader(forData: data) else {
            print("Error: unable to parse passed file. Supported formats: \(try LibsFactory.getSupportedReadingFormats())")
            return
        }
        let pixelMap = reader.read(data: data)
        
        guard let writer = try LibsFactory.getWriter(forExtension: goalFormat) else {
            print("Error: unable to create a file of the given format \(goalFormat). Supported formats: \(try LibsFactory.getSupportedWritingFormats())")
            return
        }
        let destData = writer.write(matrix: pixelMap)
        
        try destData.write(to: goalURL)
    }
    
}
