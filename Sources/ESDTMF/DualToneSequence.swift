//
//  DualToneSequence.swift
//  ESDTMF
//
//  Created by Tomohiro Kumagai on 11/18/16.
//
//

import ESAudio

/// A sequence that supplying dual tone wave samples of the dual tone signal.
public struct DualToneSequence : Sequence {
	
	public var signal: DualToneSignal
	public var volume: Volume
	public var sampleRate: DualToneSampleRate
	
	public func makeIterator() -> DualToneGenerator {
		
		return .init(signal: signal, volume: volume, sampleRate: sampleRate)
	}
}
