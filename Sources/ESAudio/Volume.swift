//
//  Volume.swift
//  ESDTMF
//
//  Created by Tomohiro Kumagai on 11/18/16.
//
//

public struct Volume {
	
	fileprivate var rawVolume: Float32 {
		
		didSet {
			
			coefficient = Volume.coefficient(fromRawVolume: rawVolume)
		}
	}
	
	/// The volume coefficient corresponds to the raw volume for sound that 2 wave synthesized for 16 bit.
	public fileprivate(set) var coefficient: Float64
	
	/// Creates a volume specified the raw volume.
	///
	/// - Precondition: the volume is allowed from 0.0 to 1.0.
	public init(_ volume: Float32) {

		guard case 0.0 ... 1.0 = volume else {
		
			fatalError("Volume is allowed from 0.0 to 1.0.")
		}
		
		rawVolume = volume
		coefficient = Volume.coefficient(fromRawVolume: volume)
	}
}

private extension Volume {
	
	/// Returns a volume coefficient for sound that 2 wave synthesized '２波形合成音' for 16 bit.
	static func coefficient(fromRawVolume volume: Float32) -> Float64 {
		
		return 32767.0 / 2.0 * Float64(volume)
	}
}

extension Volume : ExpressibleByFloatLiteral {
	
	public init(floatLiteral value: Float32) {
		
		self.init(value)
	}
}

extension Volume : CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable, CustomLeafReflectable, CustomPlaygroundQuickLookable {
	
	public var description: String {
		
		return rawVolume.description
	}
	
	public var debugDescription: String {
		
		return rawVolume.debugDescription
	}
	
	public var customMirror: Mirror {
		
		return rawVolume.customMirror
	}
	
	public var customPlaygroundQuickLook: PlaygroundQuickLook {
		
		return rawVolume.customPlaygroundQuickLook
	}
}
