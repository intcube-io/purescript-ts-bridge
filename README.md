# purescript-ts-bridge

A PureScript library for type class based TypeScript type generation (.d.ts Files).

<!-- AUTO-GENERATED-CONTENT:START (TOC) -->
- [Getting started](#getting-started)
- [Features](#features)
  - [](#)
  - [
  ](#-1)
- [Types](#types)
  - [Number](#number)
  - [String](#string)
  - [Boolean](#boolean)
  - [Array](#array)
  - [Int](#int)
  - [Char](#char)
  - [Maybe](#maybe)
  - [Tuple](#tuple)
  - [Either](#either)
  - [Nullable](#nullable)
  - [Records](#records)
  - [Functions](#functions)
- [Future features](#future-features)
- [FAQ](#faq)
- [Similar Projects](#similar-projects)
- [Support](#support)
- [Imports](#imports)
<!-- AUTO-GENERATED-CONTENT:END -->

<h2>Getting started</h2>

1. Installation
```
spago install ts-bridge
```

<!-- AUTO-GENERATED-CONTENT:START (SAMPLE) -->
A
```hs
module Sample where
```
## Imports
```hs
import Prelude

import Effect (Effect)
import TsBridge as TSB
import TsBridge as TsBridge
import Type.Proxy (Proxy)
```
Define a type class
```hs
class TsBridge a where
  tsBridge :: Proxy a -> TSB.StandaloneTsType
```
Define
```hs
data Tok = Tok

instance TsBridge a => TSB.TsBridgeBy Tok a where
  tsBridgeBy _ = tsBridge
```
Define instances
```hs
instance TsBridge Number where
  tsBridge = TSB.defaultNumber

instance TsBridge String where
  tsBridge = TSB.defaultString

instance TsBridge a => TsBridge (Array a) where
  tsBridge = TSB.defaultArray Tok

instance (TsBridge a, TsBridge b) => TsBridge (a -> b) where
  tsBridge = TSB.defaultFunction Tok

instance (TSB.DefaultRecord Tok r) => TsBridge (Record r) where
  tsBridge = TSB.defaultRecord Tok
```
Add some PureScript values
```hs
foo :: Number
foo = 1.0

bar :: { x :: Number, y :: Number } -> String
bar _ = ""
```
Define a TypeScript program with one module
```hs
myTsProgram :: TSB.TsProgram
myTsProgram =
  TSB.tsProgram
    [ TSB.tsModuleFile "Sample"
        [ TSB.tsValues Tok
            { bar
            , foo
            }
        ]

    ]
```
Define an entry point for the code generator.
```hs
main :: Effect Unit
main = TsBridge.mkTypeGenCli myTsProgram
```

<!-- AUTO-GENERATED-CONTENT:END -->


```
spago run --main App -a '--prettier "node_modules/.bin/prettier"'
```

`output/App/index.d.ts`
```ts
export const bar: (_: { readonly x: number; readonly y: number }) => string;

export const foo: number;

```

The best way to get started is to have a look at the
[demo-project](https://github.com/thought2/purescript-ts-bridge.demo).


<h2>Features</h2>

- Fully customizable. It's type class based, but the type class is defined on your side to ease selective instance implementations.
- Many default implementations to pick from
- Supports opaque types (implemented as branded types in TypeScript)
- Supports easily accessible Newtypes
- Module resolution
- Polymorphic types

<!-- AUTO-GENERATED-CONTENT:START (TYPES) -->

<table>
  
  <tr>
    <td colspan=3>
      <h3>

Number
      </h3>

Number is represented as TypeScript builtin `number` type.
      </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>


<tr>
  <td valign="top">Ref</td>
  <td valign="top">

  ```hs
  Number
  ```

  </td>
  <td valign="top">

  ```ts
  number
  ```

  </td>
</tr>
<tr></tr>


<tr>
  <td valign="top">Def</td>
  <td valign="top">

  ```hs
  <builtin>
  ```

  </td>
  <td valign="top">

  ```ts
  <builtin>
  ```

  </td>
</tr>
<tr></tr>


  <tr>
    <td colspan=3>
      <h3>

String
      </h3>

String is represented as TypeScript builtin string type.
      </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>


<tr>
  <td valign="top">Ref</td>
  <td valign="top">

  ```hs
  String
  ```

  </td>
  <td valign="top">

  ```ts
  string
  ```

  </td>
</tr>
<tr></tr>


<tr>
  <td valign="top">Def</td>
  <td valign="top">

  ```hs
  <builtin>
  ```

  </td>
  <td valign="top">

  ```ts
  <builtin>
  ```

  </td>
</tr>
<tr></tr>

</table>

<!-- AUTO-GENERATED-CONTENT:END -->


<h2>Types</h2>

The following is a list of default implementations for types that are provided in this library. Since the generation typeclass is defined on your side, you can choose a subset of the provided implementations.

<table>

  <tr>
    <td colspan=3>
      <h3>Number</h3>
      <code>Number</code> is represented as TypeScript builtin <code>number</code> type
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
Number
```

</td>
    <td valign="top">

```ts
number
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">
&lt;builtin&gt;
    </td>
    <td valign="top">
&lt;builtin&gt;
</td>
  </tr>
  <tr></tr>


  <tr>
    <td colspan=3>
      <h3>String</h3>
      <code>String</code> is represented as TypeScript builtin <code>string</code> type.
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
String
```

</td>
    <td valign="top">

```ts
string
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">
&lt;builtin&gt;
    </td>
    <td valign="top">
&lt;builtin&gt;
</td>
  </tr>
  <tr></tr>


  <tr>
    <td colspan=3>
      <h3>Boolean</h3>
      <code>Boolean</code> is represented as TypeScript builtin <code>boolean</code> type.
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
Boolean
```

</td>
    <td valign="top">

```ts
boolean
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">
&lt;builtin&gt;
    </td>
    <td valign="top">
&lt;builtin&gt;
</td>
  </tr>
  <tr></tr>


  <tr>
    <td colspan=3>
      <h3>Array</h3>
      <code>Array</code> is represented as TypeScript builtin <code>ReadonlyArray</code> type.
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
Array a
```

</td>
    <td valign="top">

```ts
ReadonlyArray<A>
```

</td>

  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">
&lt;builtin&gt;
    </td>
    <td valign="top">
&lt;builtin&gt;
</td>
  </tr>
  <tr></tr>


  <tr>
    <td colspan=3>
      <h3>Int</h3>
      <code>Int</code> is represented as opaque type using TypeScript branded types. So there is no way to create an `Int` directly in TypeScript, you need to export a functions like <code>round :: Number -> Int</code> and <code>toNumber :: Int -> Number</code> to construct and deconstruct an `Int`.
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
Int
```

</td><td valign="top">

```ts
import('../Prim').Int
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">
&lt;builtin&gt;
    </td>
    <td valign="top">

`output/Prim/index.d.ts`

```ts
type Int = {
  readonly __brand: unique symbol;
};
```

</td>
  </tr>
  <tr></tr>


  <tr>
    <td colspan=3>
      <h3>Char</h3>
      <code>Char</code> is represented as opaque type using TypeScript branded types. So there is no way to create a `Char` directly in TypeScript, you need to export a constructor and destructor functions, similar to <code>Int</code>. 
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
Char
```

</td>
    <td valign="top">

```ts
import('../Prim').Char
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">
&lt;builtin&gt;
    </td>
    <td valign="top">

`output/Prim/index.d.ts`

```ts
type Char = {
  readonly __brand: unique symbol;
};
```

</td>
  </tr>
  <tr></tr>


  <tr>
    <td colspan=3>
      <h3>Maybe</h3>
      <code>Maybe</code> is represented as opaque type using TypeScript branded types. So there is no direct way to create a <code>Maybe</code> in TypeScript. See the FAQ for the general decision to represent ADTs as opaque types.  
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
Maybe a
```

</td>
    <td valign="top">

```ts
import('../Data.Maybe').Maybe<A>
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">

`~/Data/Maybe.purs`

```hs
module Data.Maybe where

data Maybe a
  = Just a
  | Nothing
```

</td>
    <td valign="top">

`output/Data.Maybe/index.d.ts`

```ts
export type Maybe<A> = {
  readonly __brand: unique symbol;
  readonly __arg0: A;
};
```

</td>
  </tr>
  <tr></tr>


  <tr>
    <td colspan=3>
      <h3>Tuple</h3>
      <code>Tuple</code> is represented as opaque type using TypeScript __branded types. So there is no direct way to create a <code>Tuple</code> in TypeScript. See the FAQ for the general decision to represent ADTs as opaque types.  
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
Tuple a
```

</td>
    <td valign="top">

```ts
import('../Data.Tuple').Tuple<A>
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">

`~/Data/Tuple.purs`

```hs
module Data.Tuple where

data Tuple a b
  = Tuple a b
```

</td>
    <td valign="top">

`output/Data.Tuple/index.d.ts`

```ts
export type Tuple<A, B> = {
  readonly __brand: unique symbol;
  readonly __arg0: A;
  readonly __arg1: B;
};
```

</td>
  </tr>
  <tr></tr>



  <tr>
    <td colspan=3>
      <h3>Either</h3>
      <code>Either</code> is represented as opaque type using TypeScript __branded types. So there is no direct way to create a <code>Either</code> in TypeScript. See the FAQ for the general decision to represent ADTs as opaque types.  
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
Either a b
```

</td>
    <td valign="top">

```ts
import('../Data.Either').Either<A, B>
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">

`~/Data/Either.purs`

```hs
module Data.Either where

data Either a b 
  = Left a
  | Right b
```

</td>
    <td valign="top">

`output/Data.Either/index.d.ts`

```ts
export type Either<A, B> = {
  readonly __brand: unique symbol;
  readonly __arg0: A;
  readonly __arg1: B;
};
```

</td>
  </tr>
  <tr></tr>


  <tr>
    <td colspan=3>
      <h3>Nullable</h3>
      <code>Nullable</code> is represented as TypeScript untagged union.
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
Nullable a
```

</td>
    <td valign="top">

```ts
import('../Data.Nullable').Nullable<A>
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">

`~/Data/Nullable.purs`

```hs
module Data.Nullable where

foreign import data Nullable 
  :: Type -> Type
```

</td>
    <td valign="top">

`output/Data.Nullable/index.d.ts`

```ts
export type Nullable<A> = null | A;
```

</td>
  </tr>
  <tr></tr>

  <tr>
    <td colspan=3>
      <h3>Records</h3>
      Records are represented as TypeScript records with readonly fields.
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
{ name :: String
, loggedIn :: Boolean
}
```

</td>
    <td valign="top">

```ts
{
  readonly name: string;
  readonly loggedIn: boolean;
}
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">&lt;builtin&gt;</td>
    <td valign="top">&lt;builtin&gt;</td>
  </tr>

  <tr></tr>


  <tr>
    <td colspan=3>
      <h3>Functions</h3>
      Functions are represented as TypeScript functions.
    </td>
  </tr>
  <tr></tr>
  <tr>
    <th></th>
    <th>PureScript</th>
    <th>TypeScript</th>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
Number -> String -> Boolean
```

</td>
    <td valign="top">

```ts
(_: number) => (_: string) => boolean
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Ref</td>
    <td valign="top">

```hs
forall a b c. a -> b -> c
```

</td>
    <td valign="top">

```ts
<A>(_: A) => <B, C>(_: B) => C
```

</td>
  </tr>
  <tr></tr>
  <tr>
    <td valign="top">Def</td>
    <td valign="top">
&lt;builtin&gt;
</td>
    <td valign="top">
&lt;builtin&gt;
</td>
  </tr>

</table>

  - Promise
  - Variants
  - Effect
  - Unit

<h2>Future features</h2>

- Uncurried Functions

<h2>FAQ</h2>

- Q: Why are ADTs exported as opaque types. They're actually not opaque and it
  would be nice if they could be created and pattern matched on at the
  TypeScript side.
  A: The underlying representation of ADTs is not set in stone. Compilation
  backends differ in this point. For instance the official JS backend compiles
  them to OOP-ish structures in JavaScript. The newer optimized JS backend
  compiles them to discriminated unions as plain objects. Both could be
  represented in TypeScript, especially the latter is quite trivial.
  But this is not included in this library as it will make the code less
  portable.

- Q: If ADTs are fully opaque, how can I use them on the TypeScript side?
  
  A: If you export the constructors and a destructor function, you can use them to work with those types in TypeScript. For `Maybe` this would mean to export `just :: forall a. a -> Maybe a` and `nothing :: forall a. Unit -> Maybe a` and something like `onMaybe :: forall a z. (a -> z) -> (Unit -> z) -> Maybe a -> z`. Note that you have to redefine the ADT constructors as a plain function, you cannot export `Just :: forall a. a -> Maybe a` directly.
  It is easier to represent `Variant` types in TypeScript. Thus another option is to either use `Variant` in you interface or convert ADTs from and to `Variant` types. For the latter you can use a library like [labeled-data](https://github.com/thought2/purescript-labeled-data) for convenient conversions.

- Q: Is it safe to use PureScript code from TypeScript with the generated types?
  
  A: It depends. TypeScript still has the `any` type, which fits everywhere. You
  can avoid the `any` type in your codebase but they may sneak in through
  libraries. Also, TypeScript can perform arbitrary side effects at any place.
  If you export an interface that accepts a function of type `(_: number) =>
  number` you can pass a function that does some IO.

- Q: TypeScript is a structurally typed language. PureScript has both, some structural qualities like the primitive types, records, arrays. And nominal part like ADTs and newtypes. the former is easy to express in TypeScript, but the latter how is it even possible?
  
  A: In TypeScript the technique of "branded types" is an approximation to nominal typing. If a type is defined like `type T = { readonly __brand: unique symbol; } & { a : number }` there is no way to directly construct a value of that type. The only way to construct a value of type `T` is with an explicit `as` conversion: `const x : T = { a: 12 } as T`.
  If you consider the `as` conversion as a `unsafeCoerce` this is good enough to represent opaque types. Unfortunately `as` conversions are also used for safe conversions or broadening in TypeScript, like `"a" as string | number`.

<h2>Similar Projects</h2>

- [purescript-tsd-gen](https://github.com/minoki/purescript-tsd-gen)
  This project follows a different approach for type generation. It extracts TypeScript types from the PureScript CST. As such the process is more automated but less customizable.

<h2>Support</h2>

<a href='https://ko-fi.com/C0C3HQFRF' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://storage.ko-fi.com/cdn/kofi4.png?v=3' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>