stack bytecodes
extendedStoreBytecode
	| descriptor variableType variableIndex association |
	<inline: true>
	descriptor := self fetchByte.
	self fetchNextBytecode.
	variableType := descriptor >> 6 bitAnd: 3.
	variableIndex := descriptor bitAnd: 63.
	variableType = 0 ifTrue:
		[^objectMemory storePointer: variableIndex ofObject: self receiver withValue: self internalStackTop].
	variableType = 1 ifTrue:
		[^self temporary: variableIndex in: localFP put: self internalStackTop].
	variableType = 3 ifTrue:
		[association := self literal: variableIndex.
		 ^objectMemory storePointer: ValueIndex ofObject: association withValue: self internalStackTop].
	self error: 'illegal store'.
	^nil