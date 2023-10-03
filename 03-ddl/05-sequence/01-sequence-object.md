# What Is A Sequence Object

---

- SQL Server Objects
- A list of ordered numbers
- Used to generate a sequence of numeric values based on a specification
- *Order is important*
  - `{1, 2, 3}` is different from `{3, 2, 1}`
- A user-defined, schema-bound object that generates a sequence of numbers according to a specified specification
  - Number values can be ascending or descending
  - Defined interval
  - May cycle if requested
- **This is similar to the concepts of `Iterators` and `Generators` in Python**
