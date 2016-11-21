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
	public var sampleRate: DualToneSampleRate {
		
		return state.sampleRate
	}
	
	/// The current volume of dual tone wave that will generate.
	public var volume: Volume

	/// The private state to use for generating the dual tone wave.
	fileprivate var state: GenerateState

	/// Creates the dual tone generator for signal.
	///
	/// - Parameters:
	///		signal: The dual tone signal for generating.
	///		volume: The current volume of the dual tone wave.
	///		rate: The sampling rate to use for generating the dual tone wave.
	public init(signal s: DualToneSignal, volume v: Volume, sampleRate rate: DualToneSampleRate) {
		
		volume = v
		signal = s
		
		state = .init(phase: s.phase, sampleRate: rate)
	}
}

extension DualToneGenerator {
	
	/// The type contains data to use for generating the dual tone wave.
	struct GenerateState {
		
		/// The phase of the dual tone wave.
		let tonePhase: DualTonePhase

		/// The sample rate to generating the dual tone wave.
		let sampleRate: DualToneSampleRate

		/// The current phase to use for generating the dual tone wave.
		var currentPhase: DualTonePhase
		
		/// The coefficient to use for generating the dual tone wave.
		var currentPhaseStep: PhaseStep
		
		/// Creates initial state.
		init(phase: DualTonePhase, sampleRate rate: DualToneSampleRate) {
			
			tonePhase = phase
			sampleRate = rate
			
			currentPhase = .init(low: 0, high: 0)
			currentPhaseStep = .init(phase: phase, sampleRate: rate)
		}
	}
	
	/// The type expresses step of phase data.
	struct PhaseStep {
		
		var stride: DualTonePhase

		/// Creates the phase step information.
		init(phase: DualTonePhase, sampleRate rate: DualToneSampleRate) {
			
			let factorPerSample = Float64.pi * 2 / rate
			
			stride = .init(low: phase.low * factorPerSample, high: phase.high * factorPerSample)
		}
	}
}

extension DualToneGenerator.GenerateState {

	/// Procees to the next state.
	mutating func proceedToNextState() {
	
		currentPhase.advance(by: currentPhaseStep.stride)
	}
}

extension DualToneGenerator : IteratorProtocol {
	
	/// Returns a next sample of the dual tone expressed by this generator.
	public mutating func next() -> Float64? {
		
		defer {
			
			state.proceedToNextState()
		}
		
		return state.currentPhase.waveSample * volume.coefficient
	}
}
