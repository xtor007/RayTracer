//
//  File.swift
//  
//
//  Created by Illia Kniaziev on 02.04.2023.
//

import PluginInterface

final class TestPlugin: WriterPlugin {
    
    override var supportedFileType: String { "BMP wwwywo" }
    
}

final class TestPluginBuilder: PluginBuilder<WriterPlugin> {
    override func build() -> WriterPlugin {
        TestPlugin()
    }
}

@_cdecl("writerPlugin")
public func createPlugin() -> UnsafeMutableRawPointer {
    Unmanaged.passRetained(TestPluginBuilder()).toOpaque()
}
