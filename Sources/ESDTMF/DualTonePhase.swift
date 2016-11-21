//
//  DualTonePhase.swift
//  ESDTMF
//
//  Created by Tomohiro Kumagai on 11/18/16.
//
//

import Darwin.C

/// The type expresses a phase (位相) of wave sample.
struct DualTonePhase {
	
	var low: Float64
	var high: Float64
}

extension DualTonePhase {
	
	/// Returns a sample of Dual Tone wave.
	var waveSample: Float64 {
		
		return sin(low) + sin(high)
	}
	
	/// Returns the phase advanced by the specified `phase`.
	func advanced(by phase: DualTonePhase) -> DualTonePhase {
		
		return DualTonePhase(low: low + phase.low, high: high + phase.high)
	}
	
	/// Adds the given phase to this phase in place.
	mutating func advance(by phase: DualTonePhase) {

		low += phase.low
		high += phase.high
	}

}
