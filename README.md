# Objective-C KVO and Weak References Bug

This repository demonstrates a potential crash in Objective-C applications when using Key-Value Observing (KVO) with weak references.  The bug occurs when the observed object is deallocated while the observer is still registered for KVO.

## Bug Description
When a weak reference to the observed object is used in the observer, and the observed object is deallocated, the weak reference will become nil.  If a KVO notification arrives after the deallocation, attempting to access the observed object through the weak reference will result in a crash.

## Bug Reproduction
See the `bug.m` file for the code demonstrating this issue.

## Solution
The solution involves removing the observer before the observed object is deallocated.  See the `bugSolution.m` file for the corrected code.

## Contributing
Contributions are welcome!