{ name = "ts-bridge"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "arrays"
  , "console"
  , "effect"
  , "either"
  , "foldable-traversable"
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
  , "transformers"
  , "tuples"
  , "typelevel"
  , "variant"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
