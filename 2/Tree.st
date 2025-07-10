Object subclass: #Node .
Node instanceVariableNames: 'data left right' .

Node extend [
    data: anObject [
	    data := anObject
    ]

    member: anObject [
      anObject < data
          ifTrue: [^left ifNil: [false] ifNotNil: [left member: anObject]] .

      anObject > data
          ifTrue: [^right ifNil: [false] ifNotNil: [right member: anObject]] .

      ^true
    ]

    insert: anObject [
      anObject < data
          ifTrue: [left ifNil: [left := (Node new) data: anObject]
            ifNotNil: [left insert: anObject]] .

      anObject > data
          ifTrue: [right ifNil: [right := (Node new) data: anObject]
            ifNotNil: [right insert: anObject]]
    ]

    printOn: aStream [
      left ifNotNil: [left printOn: aStream] .
      data printOn: aStream .
      aStream space .
      right ifNotNil: [right printOn: aStream]
    ]
]


Object subclass: #Tree .
Tree instanceVariableNames: 'root' .

Tree extend [
    member: anObject [
      ^root ifNil: [false] ifNotNil: [root member: anObject]
    ]

    insert: anObject [
      root ifNil: [root := (Node new) data: anObject]
        ifNotNil: [root insert: anObject]
    ]

    printOn: aStream [
      aStream nextPut: $( .
      root ifNotNil: [root printOn: aStream] .
      aStream nextPut: $)
    ]
]


"Extend the Smalltalk implementation"
TreeNode extend [
    maximum [
        "Your method should answer nil if the tree is empty."
        self isEmpty ifTrue: [^nil].

        "Implement a method called maximum to compute and return the maximum value in itself."
        ^right isEmpty ifTrue: [value] ifFalse: [right maximum]
    ]
]