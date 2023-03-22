{ name = "ts-bridge"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "arrays"
  , "console"
  , "dodo-printer"
  , "effect"
  , "either"
  , "foldable-traversable"
  , "foreign-object"
  , "language-cst-parser"
  , "maybe"
  , "newtype"
  , "node-buffer"
  , "node-child-process"
  , "node-fs"
  , "node-fs-aff"
  , "node-path"
  , "nullable"
  , "optparse"
  , "ordered-collections"
  , "ordered-set"
  , "prelude"
  , "record"
  , "safe-coerce"
  , "spec"
  , "spec-discovery"
  , "strings"
  , "sunde"
  , "tidy"
  , "transformers"
  , "tuples"
  , "typelevel"
  , "variant"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
