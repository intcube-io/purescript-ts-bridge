module TsBridge
  ( module Exp
  , tsModuleFile
  , tsModuleWithImports
  , tsProgram
  , tsTypeAlias
  , tsValue
  ) where

import Prelude

import Control.Monad.Writer (listens)
import Data.Array as Array
import Data.Map as Map
import Data.Newtype (un)
import Data.Set as Set
import Data.Traversable (sequence)
import Data.Tuple.Nested ((/\))
import Data.Typelevel.Undefined (undefined)
import Heterogeneous.Mapping (class Mapping, mapping)
import Safe.Coerce (coerce)
import TsBridge.ABC (A(..), B(..), C(..), D(..), E(..), F(..), G(..), H(..), I(..), J(..), K(..), L(..), M(..), N(..), O(..), P(..), Q(..), R(..), S(..), T(..), U(..), V(..), W(..), X(..), Y(..), Z(..)) as Exp
import TsBridge.Class (class GenRecord, genRecord) as Exp
import TsBridge.DTS (PropModifiers, TsDeclVisibility(..), TsDeclaration(..), TsFilePath(..), TsFnArg(..), TsImport(..), TsModule(..), TsModuleAlias(..), TsModuleFile(..), TsModulePath(..), TsName(..), TsProgram(..), TsQualName(..), TsRecordField(..), TsType(..), TsTypeArgs(..), TsTypeArgsQuant(..), Wrap(..), dtsFilePath, mapQuantifier) as Exp
import TsBridge.DTS (TsDeclVisibility(..), TsDeclaration(..), TsImport, TsModule(..), TsModuleFile(..), TsName(..), TsProgram(..), TsType, dtsFilePath)
import TsBridge.Monad (Scope, TsBridgeAccum(..), TsBridgeM(..), TsBridge_Monad_Wrap(..), defaultTsBridgeAccum, opaqueType, runTsBridgeM) as Exp
import TsBridge.Monad (TsBridgeAccum(..), TsBridgeM, runTsBridgeM)
import TsBridge.Print (printTsDeclarations, printTsName, printTsProgram, printTsType) as Exp

tsModuleFile :: String -> Array (TsBridgeM (Array TsDeclaration)) -> Array TsModuleFile
tsModuleFile n xs =
  let
    (xs' /\ TsBridgeAccum { typeDefs, imports }) = runTsBridgeM $ join <$> sequence xs
  in
    typeDefs <> [ TsModuleFile (dtsFilePath n) (TsModule imports xs') ]

mergeModules :: Array TsModuleFile -> TsProgram
mergeModules xs =
  xs
    <#> (\(TsModuleFile mp m) -> mp /\ m)
    # Map.fromFoldableWith mergeModule
    # TsProgram

mergeModule :: TsModule -> TsModule -> TsModule
mergeModule (TsModule is1 ds1) (TsModule is2 ds2) =
  TsModule
    (is1 `Set.union` is2)
    (Array.nub (ds1 <> ds2))

tsModuleWithImports :: String -> Array TsImport -> Array (Array TsImport) -> TsModule
tsModuleWithImports = undefined

tsProgram :: Array (Array TsModuleFile) -> TsProgram
tsProgram xs = mergeModules $ join xs

tsTypeAlias :: forall mp a. Mapping mp a (TsBridgeM TsType) => mp -> String -> a -> TsBridgeM (Array TsDeclaration)
tsTypeAlias mp n x = ado
  x /\ scope <- listens (un TsBridgeAccum >>> _.scope) t
  in [ TsDeclTypeDef (TsName n) Public (coerce scope.floating) x ]
  where
  t = mapping mp x

tsValue :: forall mp a. Mapping mp a (TsBridgeM TsType) => mp -> String -> a -> TsBridgeM (Array TsDeclaration)
tsValue mp n x = do
  t <- mapping mp x
  pure [ TsDeclValueDef (TsName n) Public t ]