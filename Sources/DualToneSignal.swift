//
//  DualToneSignal.swift
//  ESDTMF
//
//  Created by Tomohiro Kumagai on 11/18/16.
//
//

//
public enum DualToneSignal : String {
	
	case tone1 = "1", tone2 = "2", tone3 = "3", toneA = "A"
	case tone4 = "4", tone5 = "5", tone6 = "6", toneB = "B"
	case tone7 = "7", tone8 = "8", tone9 = "9", toneC = "C"
	case toneAsterisk = "*", tone0 = "0", tonePound = "#", toneD = "D"
}

extension DualToneSignal {

	typealias FrequencyComponents = (Float64, Float64, Float64, Float64)
	
	/// The frequency components for low
	static var lowFrequencys = (697, 770, 852, 941) as FrequencyComponents
	
	/// The frequency components for high
	static var highFrequencys = (1209, 1336, 1477, 1633) as FrequencyComponents

	/// The phase of dual tone wave.
	static func phase(for signal: DualToneSignal) -> DualTonePhase {
		
		switch signal {
			
		case .tone1:
			return .init(low: lowFrequencys.0, high: highFrequencys.0)
			
		case .tone2:
			return .init(low: lowFrequencys.1, high: highFrequencys.0)
			
		case .tone3:
			return .init(low: lowFrequencys.2, high: highFrequencys.0)
			
		case .toneA:
			return .init(low: lowFrequencys.3, high: highFrequencys.0)
			
		case .tone4:
			return .init(low: lowFrequencys.0, high: highFrequencys.1)
			
		case .tone5:
			return .init(low: lowFrequencys.1, high: highFrequencys.1)
			
		case .tone6:
			return .init(low: lowFrequencys.2, high: highFrequencys.1)
			
		case .toneB:
			return .init(low: lowFrequencys.3, high: highFrequencys.1)
			
		case .tone7:
			return .init(low: lowFrequencys.0, high: highFrequencys.2)
			
		case .tone8:
			return .init(low: lowFrequencys.1, high: highFrequencys.2)
			
		case .tone9:
			return .init(low: lowFrequencys.2, high: highFrequencys.2)
			
		case .toneC:
			return .init(low: lowFrequencys.3, high: highFrequencys.2)
			
		case .toneAsterisk:
			return .init(low: lowFrequencys.0, high: highFrequencys.3)
			
		case .tone0:
			return .init(low: lowFrequencys.1, high: highFrequencys.3)
			
		case .tonePound:
			return .init(low: lowFrequencys.2, high: highFrequencys.3)
			
		case .toneD:
			return .init(low: lowFrequencys.3, high: highFrequencys.3)
		}
	}

	/// The phase of dual tone wave.
	///
	/// - Complexity: O(1)
	var phase: DualTonePhase {
		
		return DualToneSignal.phase(for: self)
	}
}

extension DualToneSignal : CustomStringConvertible, CustomDebugStringConvertible, CustomPlaygroundQuickLookable {
	
	public var description: String {
		
		return rawValue
	}
	
	public var debugDescription: String {
		
		return rawValue
	}
	
	public var customPlaygroundQuickLook: PlaygroundQuickLook {
		
		return .text(description)
	}
}
