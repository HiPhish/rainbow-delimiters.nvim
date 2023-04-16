(ParamDeclList
   "(" @opening
   ")" @closing) @container

(FnCallArguments
   "(" @opening
   ")" @closing) @container

(IfPrefix
   "(" @opening
   ")" @closing) @container

(ForPrefix
   "(" @opening
   ")" @closing) @container

(WhilePrefix
   "(" @opening
   ")" @closing) @container

(LinkSection
   "(" @opening
   ")" @closing) @container

(CallConv
   "(" @opening
   ")" @closing) @container

(AsmExpr
   "(" @opening
   ")" @closing) @container

(ContainerDeclType
   "(" @opening
   ")" @closing) @container

;;; BUG: regarding the next 3 pairs of queries:
;;;      since both pairs of delimiters
;;;      are direct children of the same `TSNode`
;;;      they get highligthed in different colours

;;; NOTE: https://github.com/neovim/neovim/pull/17099

(AsmInputItem
   "[" @opening
   "]" @closing) @container

(AsmInputItem
   "(" @opening
   ")" @closing) @container

(AsmOutputItem
   "[" @opening
   "]" @closing) @container

(AsmOutputItem
   "(" @opening
   ")" @closing) @container

(SwitchExpr
   "(" @opening
   ")" @closing) @container

(SwitchExpr
   "{" @opening
   "}" @closing) @container

;;; TODO: (reo101) swap out the above queries
;;;       for these (below) when 17099 (see NOTE) is merged

;; (AsmInputItem
;;    ["[" ")"]+ @opening
;;    ["]" ")"]+ @closing) @container
;;
;; (AsmOutputItem
;;    ["[" ")"]+ @opening
;;    ["]" ")"]+ @closing) @container
;;
;; (SwitchExpr
;;    ["(" "{"]+ @opening
;;    [")" "}"]+ @closing) @container

(ArrayTypeStart
   "[" @opening
   "]" @closing) @container

(SliceTypeStart
   "[" @opening
   "]" @closing) @container

(PtrTypeStart
   "[" @opening
   "]" @closing) @container

(SuffixOp
   "[" @opening
   "]" @closing) @container

(Block
   "{" @opening
   "}" @closing) @container

(ContainerDecl
   "{" @opening
   "}" @closing) @container

(InitList
   "{" @opening
   "}" @closing) @container

(FormatSequence
   "{" @opening
   "}" @closing) @container

(Payload
  "|" @opening
  "|" @closing) @container

(PtrListPayload
  "|" @opening
  "|" @closing) @container

(PtrIndexPayload
  "|" @opening
  "|" @closing) @container
