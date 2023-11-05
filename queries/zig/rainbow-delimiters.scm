(ParamDeclList
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(FnCallArguments
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(IfPrefix
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(ForPrefix
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(WhilePrefix
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(LinkSection
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(CallConv
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(AsmExpr
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(ContainerDeclType
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(AsmInputItem
   "[" @delimiter
   "]" @delimiter
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(AsmOutputItem
   "[" @delimiter
   "]" @delimiter
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(SwitchExpr
   "(" @delimiter
   ")" @delimiter
   "{" @delimiter
   "}" @delimiter @sentinel) @container

(ArrayTypeStart
   "[" @delimiter
   "]" @delimiter @sentinel) @container

(SliceTypeStart
   "[" @delimiter
   "]" @delimiter @sentinel) @container

(PtrTypeStart
   "[" @delimiter
   "]" @delimiter @sentinel) @container

(SuffixOp
   "[" @delimiter
   "]" @delimiter @sentinel) @container

(Block
   "{" @delimiter
   "}" @delimiter @sentinel) @container

(ContainerDecl
   "{" @delimiter
   "}" @delimiter @sentinel) @container

(InitList
   "{" @delimiter
   "}" @delimiter @sentinel) @container

(FormatSequence
   "{" @delimiter
   "}" @delimiter @sentinel) @container

(Payload
  "|" @delimiter
  "|" @delimiter @sentinel) @container

(PtrListPayload
  "|" @delimiter
  "|" @delimiter @sentinel) @container

(PtrIndexPayload
  "|" @delimiter
  "|" @delimiter @sentinel) @container
