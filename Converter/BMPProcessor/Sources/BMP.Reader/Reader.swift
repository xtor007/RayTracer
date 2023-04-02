//
//  File.swift
//  
//
//  Created by Illia Kniaziev on 02.04.2023.
//

import PluginInterface

final class TestPlugin: ReaderPlugin {
    
    override var supportedFileType: String { "BMP wwwywo" }
    
}

final class TestPluginBuilder: PluginBuilder<ReaderPlugin> {
    override func build() -> ReaderPlugin {
        TestPlugin()
    }
}

@_cdecl("readerPlugin")
public func createPlugin() -> UnsafeMutableRawPointer {
    Unmanaged.passRetained(TestPluginBuilder()).toOpaque()
}
