## Table of Contents

0. [Introduction](#0-introduction)
1. [Basic Syntax & Types](#1-basic-syntax--types)
2. [Functions](#2-functions)
3. [Objects & Arrays](#3-objects--arrays)
4. [Interfaces & Type Aliases](#4-interfaces--type-aliases)
5. [Classes & OOP](#5-classes--oop)
6. [Generics](#6-generics)
7. [Advanced Types](#7-advanced-types)
8. [Modules](#8-modules)
9. [Async TypeScript](#9-async-typescript)
10. [Utility Types](#10-utility-types)
11. [Pitfalls & Best Practices](#11-pitfalls--best-practices)
12. [Quick Reference](#12-quick-reference)

---

## 0. Introduction

TypeScript is JavaScript with **static typing** added on top. Any valid `.js` file is also valid TypeScript — you can rename it to `.ts` and start gradually adding types.

| Feature | JavaScript | TypeScript |
|---|---|---|
| Type checking | Runtime only | Compile-time ✅ |
| Autocompletion | Limited | Full |
| Optional static types | No | Yes |
| Compilation step | No | Yes (transpilation) |

### Compilation Flow

```
.ts source  →  tsc compiler  →  .js output
```

```bash
tsc index.ts   # generates index.js
node index.js  # Hello World
```

### Project Setup (`tsconfig.json`)

```bash
tsc --init   # generates tsconfig.json
```

| Setting | Purpose | Recommended |
|---|---|---|
| `target` | JS version output | `"es2016"` |
| `rootDir` | Source folder | `"./src"` |
| `outDir` | Output folder | `"./dist"` |
| `strict` | Enable all strict checks | `true` |
| `noEmitOnError` | Don't emit JS if TS error exists | `true` |
| `noImplicitReturns` | All code paths must return | `true` |

After configuring, compile the whole project with:

```bash
tsc
```

---

## 1. Basic Syntax & Types

### Primitive Types

```ts
let age: number = 30;
let name: string = "Alice";
let isActive: boolean = true;
let price: number = 1_000_000;  // numeric separators for readability
```

### Type Inference

Omit the annotation when the value makes the type obvious — TypeScript infers it automatically.

```ts
let count = 42;       // inferred as number
count = "hello";      // ❌ Error: string not assignable to number
```

### Special Types

| Type | When to use |
|---|---|
| `any` | Opt out of type checking — avoid unless absolutely necessary |
| `unknown` | Type isn't known yet; must narrow before using — **safer than `any`** |
| `void` | Function that returns nothing (or `undefined`) |
| `never` | Function that *never returns* — always throws or loops infinitely |

#### `unknown` vs `any`

```ts
let input: unknown = "hello";
// input.toUpperCase(); ❌ must narrow first

if (typeof input === "string") {
  input.toUpperCase();  // ✅ TypeScript now knows it's a string
}
```

> **Best practice:** Always prefer `unknown` over `any`. With `any`, type checking is completely disabled. With `unknown`, you're forced to check the type first — catching bugs at compile time.

#### `never` — exhaustive checks `[lab]`

Use `never` to make TypeScript catch missing union cases at compile time.

```ts
function neverOccur(): never {
  throw new Error("Invalid argument!");
}

function process(value: string | number): boolean {
  if (typeof value === "string") return true;
  if (typeof value === "number") return false;
  return neverOccur();  // TypeScript knows this line is unreachable
}
```

> **Key point:** If you add a new type to the union later (e.g. `string | number | boolean`), TypeScript will flag the `neverOccur()` call — forcing you to handle the new case. This is called an **exhaustive check**.

### Union & Literal Types

```ts
let id: number | string;       // union — holds either type
let dir: "left" | "right";    // literal — only these exact values

function yardToMeter(yard: number | string): number {
  if (typeof yard === "string")    // TypeScript narrows the type here
    return 0.9144 * parseFloat(yard);
  return 0.9144 * yard;
}
```

### Enums

```ts
// Numeric enum (auto-increments from 0)
enum DaysOfWeek { SAT, SUN, MON, TUE, WED, THR, FRI }
let today = DaysOfWeek.WED;  // value: 4

// String enum
enum Status { SUCCESS = "SUCCESS", FAILURE = "FAILURE" }

// Custom numeric values
enum Colors { RED = 10, GREEN = 20, BLUE = 30 }
```

#### Heterogeneous Enums — mixed values `[lab]`

You can mix numeric and string values in the same enum.

```ts
enum Database {
  CREATE,            // 0 (auto-incremented)
  UPDATE = "edit",   // string
  DELETE = 4,        // explicit number
  GET                // 5 (increments from last numeric value)
}

console.log(Database.UPDATE);  // "edit"
console.log(Database.GET);     // 5
console.log(Database[0]);      // "CREATE" — reverse mapping works for numeric members only
console.log(Database["edit"]); // undefined — string members can't be reverse-mapped
```

> **Caution:** Heterogeneous enums are rarely needed. Prefer pure numeric or pure string enums for clarity.

---

## 2. Functions

### Basic Declaration

```ts
function add(a: number, b: number): number {
  return a + b;
}

// Arrow function
const multiply = (x: number, y: number): number => x * y;
```

### Optional & Default Parameters

```ts
// Optional — use ? — must come AFTER required params
function greet(name: string, title?: string): string {
  return title ? `Hello, ${title} ${name}` : `Hello, ${name}`;
}

greet("Alice");           // ✅ title is undefined
greet("Alice", "Ms.");    // ✅

// Default value
function increaseSalary(salary: number, year: number = 2023): number {
  return year <= 2020 ? salary * 1.2 : salary * 1.1;
}

increaseSalary(5000);        // year defaults to 2023
increaseSalary(5000, 2019);  // year = 2019
```

### The `void` Return Type

```ts
function logMessage(msg: string): void {
  console.log(msg);
  // no return statement needed
}
```

### Function Overloads

Define multiple call signatures for the same function.

```ts
function process(value: string): string;
function process(value: number): number;
function process(value: string | number): string | number {
  if (typeof value === "string") return value.toUpperCase();
  return value * 2;
}
```

### `noImplicitReturns` — All Paths Must Return

Enable `"noImplicitReturns": true` in `tsconfig.json` to catch missing returns.

```ts
// ❌ Error: Not all code paths return a value
function getDiscount(price: number): number {
  if (price > 100) return price * 0.9;
  // missing return for price <= 100
}

// ✅ Fixed
function getDiscount(price: number): number {
  if (price > 100) return price * 0.9;
  return price;  // no discount
}
```

---

## 3. Objects & Arrays

### Typed Arrays

```ts
let numbers: number[] = [1, 2, 3];
let names: Array<string> = ["Alice", "Bob"];

let mixed = [1, 2, "three"];  // inferred as (number | string)[]
mixed.push(4);                // ✅
mixed.push(true);             // ❌ boolean not in the inferred type
```

### Tuples

Fixed-length arrays where each position has a specific type.

```ts
let user: [number, string] = [1, "John Doe"];
// user = ["one", "John"];  ❌ wrong type at position 0
// user = [1];              ❌ missing second element
```

> Tuples compile to plain JS arrays — the type info exists only at compile time.

#### Optional Tuple Elements `[lab]`

Mark the last element(s) as optional with `?`.

```ts
// [id, name, phone, country?]
let person: [number, string, string, string?];

person = [1, "Alex", "123456"];          // ✅ country omitted → undefined
person = [2, "John", "789012", "USA"];   // ✅ all four

// Practical example — employee with optional salary
type Employee = [number, string, string, number?];

function printEmployee(emp: Employee): void {
  console.log(`ID: ${emp[0]}, Name: ${emp[1]}, Role: ${emp[2]}, Salary: ${emp[3] ?? "not set"}`);
}
```

### Object Types

```ts
let employee: { id: number; name?: string; readonly apiUrl: string } = {
  id: 101,
  apiUrl: "https://api.example.com"
};
// employee.apiUrl = "new";  ❌ readonly

// Nested objects
let person: {
  name: string;
  address: { city: string; zip: number };
} = {
  name: "Alice",
  address: { city: "New York", zip: 10001 }
};
```

### Object Methods with `this` `[lab]`

Objects can contain functions that access the object's own properties via `this`. Use regular functions (not arrow functions) when you need the correct `this` binding.

```ts
let person = {
  name: "Ahmed",
  age: 20,
  courses: ["Concepts", "Algorithms"],
  printInfo: function() {
    console.log(`name = ${this.name}, age = ${this.age}`);
    this.courses.forEach(course => console.log(course));
  }
};

person.age = 21;
person.printInfo();
```

Typing an object with methods:

```ts
let employee: {
  name: string;
  age?: number;
  printInfo: () => void;
  getSalary: (salary: number, bonus: number) => number;
} = {
  name: "Ahmed",
  printInfo: function() {
    console.log(`name = ${this.name}, age = ${this.age}`);
  },
  getSalary: function(salary, bonus) {
    return salary + bonus;
  }
};
```

> **Note:** Arrow functions capture the surrounding `this`, not the object's `this`. Use regular `function` keyword when you need `this` to refer to the object itself.

---

## 4. Interfaces & Type Aliases

### Type Aliases

Create a reusable name for any type.

```ts
type Employee = {
  id: number;
  name: string;
  department: string;
};

let emp1: Employee = { id: 1, name: "Alice", department: "IT" };
let emp2: Employee = { id: 2, name: "Bob", department: "HR" };
```

### Interfaces

Similar to type aliases, but more powerful for OOP and object shapes.

```ts
interface Person {
  firstName: string;
  lastName: string;
  age?: number;          // optional
  readonly ssn: string;  // read-only
}

const john: Person = {
  firstName: "John",
  lastName: "Doe",
  ssn: "123-45-6789"
};
// john.ssn = "new";  ❌ readonly
```

### Extending Interfaces

```ts
interface Student extends Person {
  studentId: number;
  grade: string;
}

const alice: Student = {
  firstName: "Alice",
  lastName: "Smith",
  ssn: "987-65-4321",
  studentId: 2024001,
  grade: "A"
};
```

### Interface vs Type Alias

| Feature | Interface | Type Alias |
|---|---|---|
| Extending | `extends` keyword | `&` intersection |
| Declaration merging | ✅ Yes | ❌ No |
| Describe primitives/unions | ❌ No | ✅ Yes |
| Best for | Objects & OOP shapes | Unions, tuples, primitives |

---

## 5. Classes & OOP

### Basic Class

```ts
class Person {
  id: number;
  name: string;
  birthdate: Date;

  constructor(id: number, name: string, birthdate: Date) {
    this.id = id;
    this.name = name;
    this.birthdate = birthdate;
  }

  getAge(): number {
    return new Date().getFullYear() - this.birthdate.getFullYear();
  }
}
```

### Access Modifiers

| Modifier | Inside class | Subclasses | Outside |
|---|---|---|---|
| `public` | ✅ | ✅ | ✅ (default) |
| `protected` | ✅ | ✅ | ❌ |
| `private` | ✅ | ❌ | ❌ |

```ts
class BankAccount {
  public owner: string;
  protected balance: number;
  private pin: string;

  constructor(owner: string, balance: number, pin: string) {
    this.owner = owner;
    this.balance = balance;
    this.pin = pin;
  }
}

class SavingsAccount extends BankAccount {
  addInterest() {
    this.balance *= 1.05;  // ✅ protected is accessible in subclasses
    // this.pin = "1234";  // ❌ private is not
  }
}
```

### Inheritance

```ts
class Student extends Person {
  marks: number;

  constructor(id: number, name: string, birthdate: Date, marks: number) {
    super(id, name, birthdate);  // must call parent constructor first
    this.marks = marks;
  }

  format(): string {
    return `Student: ${this.name} (ID: ${this.id}), Marks: ${this.marks}`;
  }
}
```

### Readonly Modifier

```ts
class Config {
  readonly appName: string;

  constructor(appName: string) {
    this.appName = appName;  // ✅ only assignable in constructor
  }
}
```

### Getters & Setters

```ts
class Circle {
  private _radius: number;

  constructor(radius: number) { this._radius = radius; }

  get radius(): number { return this._radius; }

  set radius(value: number) {
    if (value <= 0) throw new Error("Radius must be positive");
    this._radius = value;
  }
}
```

### Static Members

```ts
class MathUtils {
  static PI: number = 3.14159;
  static add(a: number, b: number): number { return a + b; }
}

console.log(MathUtils.PI);       // 3.14159
console.log(MathUtils.add(5,3)); // 8
```

### Interface + Class — Full Example `[lab]`

Combining `interface`, `implements`, `protected readonly`, and `export`:

```ts
// shape.ts
export interface Shape {
  color: string;
  getArea(): number;
}

export class Square implements Shape {
  color: string;
  protected readonly length: number;  // can't change after construction; subclasses can read it

  constructor(color: string, length: number) {
    this.color = color;
    this.length = length;
  }

  getArea(): number {
    return this.length * this.length;
  }
}
```

```ts
// app.ts
import { Square } from "./shape.js";

const sq = new Square("red", 15);
console.log(sq.getArea());  // 225
// sq.length = 20;          // ❌ readonly
console.log(sq.color);      // "red"
```

> `protected` → subclasses can read the field, but outside code can't.  
> `readonly` → can only be set in the constructor, never changed after.

---

## 6. Generics

Generics let you write reusable code that stays type-safe for different types.

### Generic Functions

```ts
function identity<T>(value: T): T {
  return value;
}

let num = identity<number>(42);  // explicit — type: number
let str = identity("hello");     // inferred — type: string
```

### Generic Interfaces

```ts
interface Repository<T> {
  get(id: number): T;
  save(entity: T): void;
}

class UserRepo implements Repository<User> {
  get(id: number): User { return { id, name: "Alice" }; }
  save(user: User): void { /* ... */ }
}
```

### Generic Classes

```ts
class Stack<T> {
  private items: T[] = [];
  push(item: T): void { this.items.push(item); }
  pop(): T | undefined { return this.items.pop(); }
}

const stack = new Stack<number>();
stack.push(10);
// stack.push("text");  ❌ only numbers allowed
```

### Constraints

Restrict what types the generic accepts.

```ts
interface HasLength { length: number; }

function logLength<T extends HasLength>(item: T): void {
  console.log(item.length);
}

logLength("hello");   // ✅ string has length
logLength([1, 2, 3]); // ✅ array has length
// logLength(123);    // ❌ number has no length property
```

---

## 7. Advanced Types

### Intersection Types (`&`)

Combine multiple types — the result must satisfy **all** of them.

```ts
type Draggable = { drag: () => void };
type Resizable = { resize: () => void };

type UIWidget = Draggable & Resizable;  // must have BOTH

const widget: UIWidget = {
  drag: () => console.log("dragging"),
  resize: () => console.log("resizing")
};
```

### Custom Type Guards

```ts
function isString(value: unknown): value is string {
  return typeof value === "string";
}

function process(input: string | number) {
  if (isString(input)) input.toUpperCase();  // input is string here
  else input.toFixed(2);                     // input is number here
}
```

### `keyof` Operator

Get a union of all keys from an object type.

```ts
type PersonKeys = keyof Person;  // "name" | "age"

function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}
```

### Mapped Types

Create a new type by transforming every property.

```ts
type Readonly<T> = {
  readonly [P in keyof T]: T[P];
};

type Person = { name: string; age: number };
type ReadonlyPerson = Readonly<Person>;
// result: { readonly name: string; readonly age: number }
```

### Optional Chaining — All Three Forms `[lab]`

| Syntax | Use case |
|---|---|
| `obj?.prop` | Property access — skip if `obj` is null/undefined |
| `obj?.method?.()` | Function call — skip if method doesn't exist |
| `obj?.arr?.[1]` | Element access — skip if array doesn't exist |

```ts
type User = {
  name: string;
  getName?: () => string;
  phones?: string[];
};

const u1: User = { name: "Alex", getName: function() { return this.name; } };
const u2: User = { name: "Mark" };  // no getName, no phones

console.log(u1.getName?.());   // "Alex"
console.log(u2.getName?.());   // undefined — no error thrown
console.log(u1?.phones?.[1]);  // undefined — phones doesn't exist
```

> **Why use this?** Replaces verbose `if (obj && obj.prop && obj.prop[i])` chains with clean, safe one-liners.

---

## 8. Modules

### Named Exports & Imports

```ts
// person.ts
export class Person {
  constructor(public name: string) {}
}
export function greet(p: Person): string { return `Hello, ${p.name}`; }

// app.ts — note: use .js extension in the import path (even though source is .ts)
import { Person, greet } from "./person.js";

const alice = new Person("Alice");
console.log(greet(alice));
```

### Default Export

```ts
// logger.ts
export default function log(message: string): void {
  console.log(message);
}

// main.ts
import log from "./logger.js";  // no braces for default imports
log("Default export example");
```

---

## 9. Async TypeScript

### Typing Promises

```ts
function fetchUser(): Promise<User> {
  return fetch("/api/user").then(res => res.json());
}
```

### `async` / `await` with Types

```ts
async function getUserData(id: number): Promise<User> {
  const response = await fetch(`/api/users/${id}`);
  const data: User = await response.json();
  return data;
}
```

### Typing Fetch Responses

```ts
interface Post {
  userId: number;
  id: number;
  title: string;
  body: string;
}

async function getPosts(): Promise<Post[]> {
  const res = await fetch("https://jsonplaceholder.typicode.com/posts");
  const posts: Post[] = await res.json();
  return posts;
}
```

---

## 10. Utility Types

Built-in types that transform existing types — no need to manually redefine shapes.

| Utility | What it does | Result |
|---|---|---|
| `Partial<T>` | All props optional | `{ id?: number; name?: string }` |
| `Required<T>` | All props required | opposite of Partial |
| `Readonly<T>` | All props read-only | `{ readonly id: number; ... }` |
| `Pick<T, K>` | Keep only listed keys | `Pick<User, "id" \| "name">` → `{ id, name }` |
| `Omit<T, K>` | Exclude listed keys | `Omit<User, "id">` → `{ name, email }` |
| `Record<K, T>` | Object with fixed keys & value type | `Record<"home" \| "about", string>` |

```ts
interface User { id: number; name: string; email: string; }

// Partial — only send what changed
function updateUser(id: number, changes: Partial<User>) { /* ... */ }

// Pick — only expose safe fields
type UserPreview = Pick<User, "id" | "name">;  // { id: number; name: string }

// Omit — strip sensitive fields
type UserNoId = Omit<User, "id">;  // { name: string; email: string }

// Record — map known keys to a type
type Pages = Record<"home" | "about" | "contact", string>;

// Readonly — prevent mutation
const user: Readonly<User> = { id: 1, name: "Alice", email: "a@b.com" };
// user.name = "Bob";  ❌ readonly
```

---

## 11. Pitfalls & Best Practices

### Pitfall 1 — Overusing `any`

`any` disables type checking entirely and hides bugs.

```ts
// ❌ Don't
let data: any = fetchData();

// ✅ Do — use unknown and narrow
let data: unknown = fetchData();
if (typeof data === "string") data.toUpperCase();
```

### Pitfall 2 — Ignoring `null` / `undefined`

```ts
// ❌ Don't — crashes if address is null
console.log(user.address.city);

// ✅ Do — safe with optional chaining
console.log(user?.address?.city);
```

Enable `"strictNullChecks": true` in `tsconfig.json` to catch these at compile time.

### Pitfall 3 — Redundant Type Annotations

```ts
// ❌ Don't — redundant, TypeScript already infers this
let x: number = 5;
const names: string[] = ["a", "b"];

// ✅ Do — let inference work
let x = 5;
const names = ["a", "b"];
```

### Pitfall 4 — Unsafe Type Assertions

```ts
// ❌ Don't — forces a type without checking
const value = someData as User;

// ✅ Do — use a type guard first
if (isUser(someData)) {
  // safely use as User
}
```

### Best Practices Cheat Sheet

| ✅ Do | ❌ Don't |
|---|---|
| Use `unknown` instead of `any` | Use `any` as a shortcut |
| Enable `strict: true` in tsconfig | Ignore compiler errors |
| Add return types for public functions | Leave return type ambiguous |
| Use `readonly` for immutable properties | Mutate objects unexpectedly |
| Use union types + type guards | Use `as` assertions carelessly |
| Use utility types (`Partial`, `Pick`) | Redefine existing type shapes |
| Use optional chaining `?.` | Chain long manual null checks |

---

## 12. Quick Reference

### All Types at a Glance

| Type | Example | Description |
|---|---|---|
| `number` | `let age: number = 30` | Integers, floats |
| `string` | `let name: string = "Alice"` | Text |
| `boolean` | `let ok: boolean = true` | `true` / `false` |
| `number[]` | `let list: number[] = [1,2]` | Typed array |
| `[string, number]` | `let x: [string, number]` | Tuple — fixed positions |
| `enum` | `enum Color {Red, Green}` | Named constants |
| `any` | `let d: any = "whatever"` | Opt out — avoid |
| `unknown` | `let d: unknown = "safe"` | Type-safe `any` — prefer |
| `void` | `function f(): void {}` | No return value |
| `never` | `function err(): never {}` | Never returns |

### Declaration Syntax

```ts
type Point = { x: number; y: number };         // type alias
interface Point { x: number; y: number; }      // interface
let p: { x: number; y: number } = { x:10, y:20 };  // inline
```

### Optional Chaining — All Forms

```ts
obj?.prop          // property access
obj?.method?.()    // function call
obj?.arr?.[index]  // element access
```

### Access Modifiers Summary

| Modifier | Class | Subclass | External |
|---|---|---|---|
| `public` | ✅ | ✅ | ✅ |
| `protected` | ✅ | ✅ | ❌ |
| `private` | ✅ | ❌ | ❌ |

### tsconfig.json Key Options

| Option | Default | Recommended |
|---|---|---|
| `strict` | `false` | `true` |
| `noImplicitReturns` | `false` | `true` |
| `noUnusedLocals` | `false` | `true` |
| `noEmitOnError` | `false` | `true` |
| `target` | `es2016` | `es2016`+ |
| `outDir` | — | `"./dist"` |
| `rootDir` | — | `"./src"` |

### Lab-Added Concepts at a Glance `[lab]`

| Concept | Key example |
|---|---|
| `never` for exhaustive checks | `return neverOccur()` after handling all union cases |
| Heterogeneous enum | `enum Database { CREATE, UPDATE = "edit", DELETE = 4, GET }` |
| Optional tuple element | `[number, string, string?]` |
| Object method with `this` | `printInfo: function() { console.log(this.name); }` |
| Optional chaining `?.()` | `user?.getName?.()` |
| Optional chaining `?.[]` | `user?.phones?.[1]` |
| `protected readonly` field | `protected readonly length: number;` |

---

*Practice each example in the [TypeScript Playground](https://www.typescriptlang.org/play) or your local setup. See the [official handbook](https://www.typescriptlang.org/docs/handbook/intro.html) for deeper dives.*
