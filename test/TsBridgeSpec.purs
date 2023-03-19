module TsBridgeSpec
  ( spec
  ) where

import Prelude

import Data.Either (Either)
import Data.Map (Map)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable)
import Data.String (Pattern(..))
import Data.String as String
import Data.Symbol (class IsSymbol)
import Data.Tuple (fst)
import Data.Tuple.Nested (type (/\), (/\))
import Effect (Effect)
import Test.Spec (Spec, describe, it)
import Test.Util (shouldEqual)
import TsBridge (class DefaultRecord, class ToTsBridgeBy, TsDeclaration, TsProgram, TsType, Var(..), runTsBridgeM, tsValue)
import TsBridge as TSB
import TsBridge.Monad (TsBridgeM)
import TsBridge.Print (printTsDeclarations, printTsType)
import Type.Proxy (Proxy(..))

class ToTsBridge a where
  toTsBridge :: a -> TsBridgeM TsType

instance ToTsBridge a => ToTsBridge (Proxy a) where
  toTsBridge = TSB.defaultProxy Tok

instance ToTsBridge Number where
  toTsBridge = TSB.defaultNumber

instance ToTsBridge String where
  toTsBridge = TSB.defaultString

instance ToTsBridge Boolean where
  toTsBridge = TSB.defaultBoolean

instance ToTsBridge a => ToTsBridge (Array a) where
  toTsBridge = TSB.defaultArray Tok

instance ToTsBridge a => ToTsBridge (Effect a) where
  toTsBridge = TSB.defaultEffect Tok

instance ToTsBridge a => ToTsBridge (Nullable a) where
  toTsBridge = TSB.defaultNullable Tok

instance (ToTsBridge a, ToTsBridge b) => ToTsBridge (a -> b) where
  toTsBridge = TSB.defaultFunction Tok

instance (DefaultRecord Tok r) => ToTsBridge (Record r) where
  toTsBridge = TSB.defaultRecord Tok

instance ToTsBridge a => ToTsBridge (Maybe a) where
  toTsBridge = TSB.defaultOpaqueType "Data.Maybe" "Maybe" [ "A" ]
    [ toTsBridge (Proxy :: _ a) ]

instance (ToTsBridge a, ToTsBridge b) => ToTsBridge (Either a b) where
  toTsBridge = TSB.defaultOpaqueType "Data.Either" "Either" [ "A", "B" ]
    [ toTsBridge (Proxy :: _ a), toTsBridge (Proxy :: _ b) ]

instance IsSymbol sym => ToTsBridge (Var sym) where
  toTsBridge _ = TSB.defaultTypeVar (Var :: _ sym)

instance ToTsBridge Unit where
  toTsBridge = TSB.defaultUnit

--

data Tok = Tok

instance ToTsBridge a => ToTsBridgeBy Tok a where
  toTsBridgeBy _ = toTsBridge

--

spec :: Spec Unit
spec = do
  describe "TsBridgeSpec" do
    -- describe "Program Printing" do
    -- describe "Program with imports" do
    --   it "generates a type alias and adds the type module" do
    --     tsProgram
    --       [ tsModuleFile "types"
    --           [ tsTypeAlias Tok "Foo" (Proxy :: _ (Either String Boolean)) ]
    --       , tsModuleFile "Data.Either/index"
    --           [ tsOpaqueType Tok "Either" (Proxy :: _ (Either String Boolean)) ]
    --       ]
    --       # printTsProgram
    --       # shouldEqual
    --       $ Map.fromFoldable
    --           [ textFile "types.d.ts"
    --               [ "import * as Data_Either from '~/Data.Either/index'"
    --               , ""
    --               , "export type Foo = Data_Either.Either<string, boolean>"
    --               ]
    --           , textFile "Data.Either/index.d.ts"
    --               [ "import * as Data_Either from '~/Data.Either/index'"
    --               , ""
    --               , "export type Either<A, B> = { readonly opaque_Either: unique symbol; readonly arg0: A; readonly arg1: B; }"
    --               ]
    --           ]

    describe "Declaration Printing" do
      -- describe "tsTypeAlias" do
      --   describe "Number" do
      --     testDeclPrint
      --       (tsTypeAlias Tok "Foo" (Proxy :: _ Number))
      --       [ "export type Foo = number" ]

      --   describe "Type Variable" do
      --     testDeclPrint
      --       (tsTypeAlias Tok "Foo" (Proxy :: _ A))
      --       [ "export type Foo<A> = A" ]

      --   describe "Type Variables" do
      --     testDeclPrint
      --       (tsTypeAlias Tok "Foo" (Proxy :: _ { c :: C, sub :: { a :: A, b :: B } }))
      --       [ "export type Foo<C, A, B> = { readonly c: C; readonly sub: { readonly a: A; readonly b: B; }; }" ]

      --   describe "" do
      --     testDeclPrint
      --       (tsTypeAlias Tok "Foo" (Proxy :: _ (A -> B -> C)))
      --       [ "export type Foo = <A>(_: A) => <B, C>(_: B) => C" ]

      --   describe "" do
      --     testDeclPrint
      --       (tsTypeAlias Tok "Foo" (Proxy :: _ (A -> A -> A)))
      --       [ "export type Foo = <A>(_: A) => (_: A) => A" ]

      describe "tsValue" do
        describe "Number" do
          testDeclPrint
            (tsValue Tok "foo" 13.0)
            [ "export const foo : number" ]

    describe "Type Printing" do
      describe "Number" do
        testTypePrint (toTsBridge (Proxy :: _ Number))
          "number"

      describe "String" do
        testTypePrint (toTsBridge (Proxy :: _ String))
          "string"

      describe "Boolean" do
        testTypePrint (toTsBridge (Proxy :: _ Boolean))
          "boolean"

      describe "Array" do
        testTypePrint (toTsBridge (Proxy :: _ (Array Boolean)))
          "Array<boolean>"

      describe "Effect" do
        testTypePrint (toTsBridge (Proxy :: _ (Effect Unit)))
          "() => void"

      describe "Function" do
        testTypePrint (toTsBridge (Proxy :: _ (String -> Number -> Boolean)))
          "(_: string) => (_: number) => boolean"

      describe "Record" do
        testTypePrint (toTsBridge (Proxy :: _ { bar :: String, foo :: Number }))
          "{ readonly bar: string; readonly foo: number; }"

      describe "Maybe" do
        testTypePrint (toTsBridge (Proxy :: _ (Maybe Boolean)))
          "import('~/Data.Maybe').Maybe<boolean>"

      describe "Either" do
        testTypePrint (toTsBridge (Proxy :: _ (Either String Boolean)))
          "import('~/Data.Either').Either<string, boolean>"

      describe "Nullable" do
        testTypePrint (toTsBridge (Proxy :: _ (Nullable String)))
          "(null)|(string)"

testDeclPrint :: TsBridgeM (Array TsDeclaration) -> Array String -> Spec Unit
testDeclPrint x s =
  it "prints the correct declaration" do
    runTsBridgeM x
      # fst
      # printTsDeclarations
      # shouldEqual s

testTypePrint :: TsBridgeM TsType -> String -> Spec Unit
testTypePrint x s =
  it "prints the correct type" do
    shouldEqual
      ( runTsBridgeM x
          # fst
          # printTsType
      )
      s

textFile :: String -> Array String -> String /\ Array String
textFile n lines = n /\ lines

printTsProgram :: TsProgram -> Map String (Array String)
printTsProgram x = TSB.printTsProgram x <#> String.split (Pattern "\n")