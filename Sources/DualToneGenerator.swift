//
//  DualToneGenerator.swift
//  ESDTMF
//
//  Created by Tomohiro Kumagai on 11/18/16.
//
//

/// The dual tone wave generator.
public struct DualToneGenerator {

	/// The dual tone signal for generating dual tone wave.
	public let signal: DualToneSignal
	
	/// The sample rate to generating the dual tone wave.
	public let sampleRate: DualToneSampleRate
	
	/// The current volume of dual tone wave that will generate.
	public var volume: Volume

	/// The phase of the dual tone wave.
	fileprivate let tonePhase: DualTonePhase

	/// The current phase to use for generating the dual tone wave.
	fileprivate var currentPhase: DualTonePhase
	
	/// The coefficient to use for generating the dual tone wave.
	fileprivate var currentPhaseStep: PhaseStep

	/// Creates the dual tone generator for signal.
	///
	/// - Parameters:
	///		signal: The dual tone signal for generating.
	///		volume: The current volume of the dual tone wave.
	///		rate: The sampling rate to use for generating the dual tone wave.
	public init(signal s: DualToneSignal, volume v: Volume, sampleRate rate: DualToneSampleRate) {
		
		volume = v
		signal = s
		
		tonePhase = s.phase
		sampleRate = rate
		
		currentPhase = .init(low: 0, high: 0)
		currentPhaseStep = .init(phase: tonePhase, sampleRate: sampleRate)
	}
}

extension DualToneGenerator {
	
	/// The type expresses step of phase data.
	struct PhaseStep {
		
		var stride: DualTonePhase

		/// Creates the phase step information.
		init(phase: DualTonePhase, sampleRate rate: DualToneSampleRate) {
			
			let base = Float64.pi * 2 / rate
			
			self.stride = .init(low: phase.low * base, high: phase.high * base)
		}
	}
}

extension DualToneGenerator : IteratorProtocol {
	
	/// Returns a next sample of the dual tone expressed by this generator.
	public mutating func next() -> Float64? {
		
		defer {
			
			currentPhase.advance(by: currentPhaseStep.stride)
		}
		
		return currentPhase.waveSample * volume.coefficient
	}
}
