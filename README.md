# How Easy is ROS with Not-So-Random Oracles?

This is a tool for solving 2-ROS instances for the following families of non-cryptographic hash functions:
- Affine (e.g. H(x,y) = ax + by + c)
- FNV32-1a

## Usage

To solve a 2-ROS instance for a prime p < 2^16, salt s (48 bits in format `#xXXXXYYYYZZZZ`), and an affine hash function, run: `./solve.sh affine p s`. For example, to solve a affine 2-ROS instance with $p=1013$ and salt `#x000100020003` (this will set H(x,y) = 2x+3y+1), run the command `./solve.sh affine 1013 '#x000100020003'`. You can do the same thing for FNV32-1a instead of affine by changing "affine" to "fnv32".

Tip: use `printf %x\n` to get the hexadecimal representation of a number.

## Benchmarks

To benchmark the tool for affine hash functions, run `./benchmark.sh affine`. For FNV32-1a, run `./benchmark.sh fnv32`. You can use Ctrl+C to skip a specific test.
