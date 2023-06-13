(exp_parens
  (("(" @opening)
   (")" @closing))) @container

(exp_tuple
  (("(" @opening)
   (")" @closing))) @container

(con_unit
  (("(" @opening)
   (")" @closing))) @container

(exports
  (("(" @opening)
   (")" @closing))) @container

(export_names
  (("(" @opening)
   (")" @closing))) @container

(import_list
  (("(" @opening)
   (")" @closing))) @container

(import_item
  (("(" @opening)
   (")" @closing))) @container

(type_parens
  (("(" @opening)
   (")" @closing))) @container

(type_tuple
  (("(" @opening)
   (")" @closing))) @container

(pat_parens
  (("(" @opening)
   (")" @closing))) @container

(pat_tuple
  (("(" @opening)
   (")" @closing))) @container

(type_tuple
  (("(" @opening)
   (")" @closing))) @container

(deriving
  (("(" @opening)
   (")" @closing))) @container

(record_fields
  (("{" @opening)
   ("}" @closing))) @container

(exp_record
  (("{" @opening)
   ("}" @closing))) @container

(pat_fields
  (("{" @opening)
   ("}" @closing))) @container

(exp_list
  (("[" @opening)
   ("]" @closing))) @container

(type_list
  (("[" @opening)
   ("]" @closing))) @container
