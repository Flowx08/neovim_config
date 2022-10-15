syn keyword syntaxLabel Actions Knowledge Types Protocol Goals
syn keyword syntaxKW Agent Number Function Symmetric_key where authenticates
syn match syntaxKW "secret between"
syn match syntaxComment "#.*$"
syn match syntaxCommunication ".*:"

hi def link syntaxLabel Statement
hi def link syntaxKW Number
hi def link syntaxComment Comment
hi def link syntaxCommunication Type
